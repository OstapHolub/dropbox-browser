//
//  NetworkingError.swift
//  Core
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Describes possible networking code errors that happens before sending
/// an `HTTP` request or response processing.
public enum NetworkingError: Error {
    case invalidResource
    case encoding
    case decoding(rawData: Data, error: Error)
    case unknown
    case responseProcessing
    case invalidView
}

// MARK: - LocalizedError

/// Internal extension providing localized description for an error.
extension NetworkingError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case let .decoding(_, error):
            return error.localizedDescription
        case .invalidView:
            return "Requested and actual views mismatch"
        default:
            return String(describing: self)
        }
    }
}
