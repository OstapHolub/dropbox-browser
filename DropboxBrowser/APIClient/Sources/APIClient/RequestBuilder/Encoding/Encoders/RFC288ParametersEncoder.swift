//
// RFC288ParametersEncoder.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

final class RFC288ParametersEncoder: ParametersEncoder {

    func encode<T>(_ apiRequest: T, baseURL: URL) throws -> URLRequest where T: APIRequest {
        var request = URLRequest(url: baseURL)

        guard let messageValue = apiRequest.rfc288Value else {
            fatalError("Request \(apiRequest) should never got here!")
        }

        request.httpBody = messageValue.data(using: .utf8)
        return request
    }
}
