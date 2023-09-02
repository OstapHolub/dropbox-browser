//
// URLSessionClient+Request.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Part of the `URLSessionClient` responsible for sending requests.
extension URLSessionClient {

    func send<T>(_ request: T,
                 requestBuilder: RequestBuilder) async throws -> T.Response where T: APIRequest {
        let urlRequest = try requestBuilder.makeRequest(request, baseURL: baseURL)
        let (data, response) = try await session.data(for: urlRequest)
        return try process(responseData: data, response: response, request: request)
    }
}
