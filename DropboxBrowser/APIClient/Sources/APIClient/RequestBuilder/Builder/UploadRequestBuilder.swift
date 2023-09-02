//
// UploadRequestBuilder.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

// swiftlint:disable all
import Foundation

public final class UploadRequestBuilder: RequestBuilder {

    private let authorizationProvider: AuthorizationStrategyProvider

    public init(authorizationProvider: AuthorizationStrategyProvider) {
        self.authorizationProvider = authorizationProvider
    }

    // MARK: - Interface
    public func makeRequest<T>(_ apiRequest: T, baseURL: URL) throws -> URLRequest where T: APIRequest {
        var resourceURL: URL

        if #available(iOS 16, *) {
            resourceURL = baseURL.appending(path: apiRequest.resourceName)
        } else {
            guard let url = URL(string: apiRequest.resourceName, relativeTo: baseURL) else {
                throw NetworkingError.invalidResource
            }
            resourceURL = url
        }

        guard let components = URLComponents(url: resourceURL, resolvingAgainstBaseURL: true) else {
            throw URLParametersEncoderError.baseURLParsingFailed
        }

        guard let url = components.url else {
            throw URLParametersEncoderError.urlAssemblingFailed
        }

        var request =  URLRequest(url: url)
        let parametersData = try JSONEncoder().encode(apiRequest)
        let parameters = try JSONDecoder().decode([String: HTTPParameter].self, from: parametersData)

        guard let fileURL = parameters[FileUpload.Key.fileURL.rawValue]?.url,
                let filename = parameters[FileUpload.Key.filename.rawValue]?.string,
                let boundary = parameters[FileUpload.Key.boundary.rawValue]?.string else {
            throw URLParametersEncoderError.urlAssemblingFailed
        }

        request.httpBody = createHttpBody(binaryData: try Data(contentsOf: fileURL),
                                          mimeType: fileURL.mimeType,
                                          filename: filename,
                                          boundary: boundary)
        putHeaders(into: &request, from: apiRequest)

        request.httpMethod = apiRequest.method.rawValue
        return request
    }
}

// MARK: - Private processing

private extension UploadRequestBuilder {

    /// Adds content of `additionalHeaders` from `APIRequest` instance into `URLRequest`.
    func putHeaders<T: APIRequest>(into request: inout URLRequest, from apiRequest: T) {

        if apiRequest.requiresAuth {
            let strategy = authorizationProvider.makeStrategy(apiRequest.authorization)
            if let authorization = strategy.value {
                request.addValue(authorization, forHTTPHeaderField: "Authorization")
            }
        }

        if let additionalHeaders = apiRequest.additionalHeaders {
            for (headerField, value) in additionalHeaders {
                request.addValue(value, forHTTPHeaderField: headerField)
            }
        }
    }

    private func createHttpBody(binaryData: Data, mimeType: String, filename: String, boundary: String) -> Data {
        var postContent = "--\(boundary)\r\n"
        postContent += "Content-Disposition: form-data; name=\"\(filename)\"; filename=\"\(filename)\"\r\n"
        postContent += "Content-Type: \(mimeType)\r\n\r\n"

        var data = Data()
        guard let postData = postContent.data(using: .utf8) else { return data }
        data.append(postData)
        data.append(binaryData)

        guard let endData = "\r\n--\(boundary)--\r\n".data(using: .utf8) else { return data }
        data.append(endData)
        return data
    }
}
