//
// HTTPError.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Describes possible `HTTP` protocol errors that might appear during
/// execution of Network code.
public enum HTTPError: Error {
    case badRequest(HTTPErrorPayload)
    case unauthorised
    case notFound(HTTPErrorPayload)
    case internalServer(HTTPErrorPayload)
    case tooManyRequests(HTTPErrorPayload)
    case forbidden(HTTPErrorPayload)
}

// MARK: - LocalizedError

/// Internal extension providing localized description for an error.
extension HTTPError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case let .badRequest(payload),
            let .notFound(payload),
            let .internalServer(payload),
            let .tooManyRequests(payload),
            let .forbidden(payload):
            return payload.message
        case .unauthorised:
            return "Not authorized to perform the request."
        }
    }
}
