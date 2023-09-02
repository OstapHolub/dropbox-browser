//
//  URLParametersEncoder.swift
//  APIClient
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

enum URLParametersEncoderError: Error {
    case baseURLParsingFailed
    case urlAssemblingFailed
}

/// Encodes `APIRequest` parameters as URL query items into `URLRequest.url` property.
final class URLParametersEncoder: ParametersEncoder {

    func encode<T>(_ apiRequest: T, baseURL: URL) throws -> URLRequest where T: APIRequest {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { throw URLParametersEncoderError.baseURLParsingFailed }
        let customQueryItems: [URLQueryItem]
        do {
            customQueryItems = try URLParametersEncoder.encode(apiRequest)
        } catch {
            fatalError("Wrong parameters: \(error)")
        }
        if customQueryItems.isEmpty == false {
            components.queryItems = customQueryItems
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }

        guard let url = components.url else { throw URLParametersEncoderError.urlAssemblingFailed }
        return URLRequest(url: url)
    }
}

// MARK: - Private processing

private extension URLParametersEncoder {

    static func encode<T: APIRequest>(_ request: T) throws -> [URLQueryItem] {
        let parametersData = try JSONEncoder().encode(request)
        let parameters = try JSONDecoder().decode([String: HTTPParameter].self, from: parametersData)
        return parameters.flatMap { queryComponents(fromKey: $0, value: $1) }.map { URLQueryItem(name: $0, value: $1) }
    }

    static func queryComponents(fromKey key: String, value: HTTPParameter) -> [(String, String?)] {
        switch value {
        case .string(let value):
            return [(key, value)]
        case .bool(let value):
            return [(key, String(value))]
        case .double(let value):
            return [(key, String(value))]
        case .int(let value):
            return [(key, String(value))]
        case let .array(array):
            return array.map { ("\(key)[]", $0) }
        }
    }
}
