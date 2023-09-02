//
// URLSessionClient+Response.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Part of the `URLSessionClient` responsible for processing response `Data`.
extension URLSessionClient {

    func process<T: APIRequest>(responseData data: Data,
                                response: URLResponse,
                                request: T) throws -> T.Response {

        let headers = (response as? HTTPURLResponse)?.allHeaderFields ?? [:]
        let decoder = ResponseDecoderFactory.makeDecoder(for: headers)

        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        switch statusCode {
        case 200...299:
            do {
                return try decoder.decode(T.Response.self, from: data)
            } catch {
                print(error)
                throw NetworkingError.decoding(rawData: data, error: error)
            }
        case 400:
            let payload = try decoder.decode(HTTPErrorPayload.self, from: data)
            throw HTTPError.badRequest(payload)
        case 401:
            throw HTTPError.unauthorised
        case 403:
            let payload = try decoder.decode(HTTPErrorPayload.self, from: data)
            throw HTTPError.forbidden(payload)
        case 429:
            let payload = try decoder.decode(HTTPErrorPayload.self, from: data)
            throw HTTPError.tooManyRequests(payload)
        case 500:
            let payload = try decoder.decode(HTTPErrorPayload.self, from: data)
            throw HTTPError.internalServer(payload)
        default:
            throw NetworkingError.unknown
        }
    }
}
