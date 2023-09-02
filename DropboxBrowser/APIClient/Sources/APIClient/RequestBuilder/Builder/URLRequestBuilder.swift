//
//  URLRequestBuilder.swift
//  APIClient
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Builds an instance of `URLRequest`
public final class URLRequestBuilder: RequestBuilder {

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

        let encoder: ParametersEncoder = ParametersEncodingFactory.makeEncoder(for: apiRequest)
        var request: URLRequest = try encoder.encode(apiRequest, baseURL: resourceURL)
        putHeaders(into: &request, from: apiRequest)

        request.httpMethod = apiRequest.method.rawValue
        return request
    }
}

// MARK: - Private processing

private extension URLRequestBuilder {

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
}
