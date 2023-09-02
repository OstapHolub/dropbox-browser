//
// AuthError.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

public enum AuthError: Error, Equatable {
    case unknown(String)
    case invalidRequest(String)
    case accessDenied(String)
    case unauthorizedClient(String)
    case unsupportedResponseType(String)
    case invalidScope(String)
    case serverError(String)
    case temporarilyUnavailable(String)
}

extension AuthError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case let .unknown(message),
            let .invalidRequest(message),
            let .accessDenied(message),
            let .unauthorizedClient(message),
            let .unsupportedResponseType(message),
            let .invalidScope(message),
            let .serverError(message),
            let .temporarilyUnavailable(message):
            return message
        }
    }

    public static func makeError(key: String, message: String) -> AuthError? {
        switch key {
        case "unknown": return .unknown(message)
        case "invalid_request": return .invalidRequest(message)
        case "access_denied": return .accessDenied(message)
        case "unauthorized_client": return .unauthorizedClient(message)
        case "unsupported_response_type": return .unsupportedResponseType(message)
        case "invalid_scope": return .invalidScope(message)
        case "server_error": return .serverError(message)
        case "temporarily_unavailable": return .temporarilyUnavailable(message)
        default: return nil
        }
    }
}
