//
//  ParametersEncodingFactory.swift
//  APIClient
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Desides and creates instance of `ParameterEncoder` protocol implementation based on `HTTPMethod`.
enum ParametersEncodingFactory {

    static func makeEncoder<T>(for apiRequest: T) -> ParametersEncoder where T: APIRequest {

        let method = apiRequest.method.rawValue

        if method == "GET" || method == "DELETE" {
            return URLParametersEncoder()
        } else if method == "POST" || method == "PUT" {
            guard apiRequest.contentType == .applicationJson else {
                return RFC288ParametersEncoder()
            }
            return JSONParametersEncoder()
        } else {
            fatalError("Not supported type: \(method)")
        }
    }
}
