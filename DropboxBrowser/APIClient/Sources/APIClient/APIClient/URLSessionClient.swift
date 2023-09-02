//
// URLSessionClient.swift
// APIClient
//
// Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// `URLSession` powered implementaion of `APIClient` protocol.
public class URLSessionClient: APIClient {

    /// URLSession isntance to perform network request.
    let session: URLSession

    /// Base URL for session to build `APIRequest` resource URL.
    let baseURL: URL

    /// Instance of `URLRequestBuilder` to transform `APIRequest` protocol
    /// implementation into instance of `URLRequest`.
    private let requestBuilder: URLRequestBuilder

    /// Instance of `UploadRequestBuilder` to transform `APIRequest` protocol
    /// and file `URL` to instance of `URLRequest`.
    private let uploadBuilder: UploadRequestBuilder

    public init(session: URLSession = URLSession.shared,
                requestBuilder: URLRequestBuilder,
                uploadBuilder: UploadRequestBuilder,
                baseURL: URL) {
        self.session = session
        self.baseURL = baseURL
        self.requestBuilder = requestBuilder
        self.uploadBuilder = uploadBuilder
    }

    // MARK: - Send Request Interface

    public func send<T>(_ request: T) async throws -> T.Response where T: APIRequest {
        return try await send(request, requestBuilder: requestBuilder)
    }

    // MARK: - File Upload Interface

    public func upload<T>(_ request: T, fileURL: URL) async throws -> T.Response where T: APIRequest {
        return try await send(request, requestBuilder: uploadBuilder)
    }

    // MARK: - File Download Interface

    public func download<T>(_ request: T) async throws -> URL where T: APIRequest {
        let urlRequest = try requestBuilder.makeRequest(request, baseURL: baseURL)
        let (url, _) = try await session.download(for: urlRequest, delegate: nil)

        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw NetworkingError.responseProcessing
        }

        let fileURL = documentsDirectory.appendingPathComponent(url.lastPathComponent)
        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
            }
            try FileManager.default.moveItem(at: url, to: fileURL)
            return fileURL
        } catch {
            throw NetworkingError.responseProcessing
        }
    }
}
