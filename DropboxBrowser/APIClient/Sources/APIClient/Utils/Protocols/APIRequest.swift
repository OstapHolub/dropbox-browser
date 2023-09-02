//
//  APIRequest.swift
//  
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Describes protocol for HTTP APIRequest.
public protocol APIRequest: Encodable {

    /// Associated type that represents any `Decodable` object to be treated as
    /// HTTP response data.
    associatedtype Response: Decodable

    /// Route to endpoint of resource.
    var resourceName: String { get }

    /// HTTP Method to be used to perform HTTP API Request.
    var method: HTTPMethod { get }

    /// Additional HTTP headers to be sent with request.
    var additionalHeaders: [String: String]? { get }

    /// Indicates which type of authorization is supported.
    var authorization: Authorization { get }

    /// Indicates wheter the request requires authentication header to be present
    /// in order to be sent.
    var requiresAuth: Bool { get }

    /// Content type of request.
    var contentType: RequestContentType { get }

    /// Optional RFC288 value as workaround. Always nil.
    var rfc288Value: String? { get }
}

/// Provides convenience configuration for any implementation of `APIRequest`
public extension APIRequest {

    var authorization: Authorization { .none }
    var requiresAuth: Bool { true }
    var additionalHeaders: [String: String]? { nil }
    var contentType: RequestContentType { .applicationJson }
    var rfc288Value: String? { nil }
}
