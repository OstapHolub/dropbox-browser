//
//  ParametersEncoder.swift
//  APIClient
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Encodes parameters of `APIRequest` implementation instance
/// into `URLRequest` parameters.
protocol ParametersEncoder {

    /// Encodes parameter of `APIRequest` into `URLRequest` based on `HTTP` method.
    /// - Parameters:
    ///    - apiRequest: implementation instance of `APIRequest` protocol
    ///    - baseURL: base `URL` of your server to create requests for.
    /// - Returns: instance of `URLRequest` with encoded into it parameters.
    func encode<T: APIRequest>(_ apiRequest: T, baseURL: URL) throws -> URLRequest
}
