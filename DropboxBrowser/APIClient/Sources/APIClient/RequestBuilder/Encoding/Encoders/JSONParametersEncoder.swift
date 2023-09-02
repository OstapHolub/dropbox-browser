//
//  JSONParametersEncoder.swift
//  APIClient
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Encodes `APIRequest` parameters as JSON into `URLRequest.httpBody` property.
final class JSONParametersEncoder: ParametersEncoder {

    func encode<T>(_ apiRequest: T, baseURL: URL) throws -> URLRequest where T: APIRequest {

        var request = URLRequest(url: baseURL)

        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(apiRequest)
            request.httpBody = jsonData
        } catch {
            throw NetworkingError.encoding
        }

        return request
    }
}
