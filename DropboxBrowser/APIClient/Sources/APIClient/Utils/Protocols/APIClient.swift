//
//  APIClient.swift
//
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Defines protocol for custom APIClient implementations.
public protocol APIClient {

    /// Sends request over the HTTP protocol.
    /// - Parameter request: Instance of `APIRequest` protocol implementation
    /// describing the request to be sent.
    /// - Returns: Return instance of associated type of `APIRequest.Response`.
    func send<T: APIRequest>(_ request: T) async throws -> T.Response

    /// Downloads content of URL defined by request.
    /// - Parameters:
    ///   - request: Instance of `APIRequest` protocol implementation describing the request to be sent.
    func download<T: APIRequest>(_ request: T) async throws -> URL

    /// Uploads content of URL.
    /// - Parameters:
    ///   - request: Instance of `APIRequest` protocol implementation describing the request to be sent.
    func upload<T: APIRequest>(_ request: T, fileURL: URL) async throws -> T.Response
}
