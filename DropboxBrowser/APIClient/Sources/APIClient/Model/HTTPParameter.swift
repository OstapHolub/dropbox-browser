//
//  HTTPParameter.swift
//  APIClient
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Internal model enum used as auxiliary type for encoding/decoding process for
/// `APIRequest` and it's `APIRequest.Response`.
/// Used for `URLEncoding` startegy like for `GET` requests.
enum HTTPParameter: Decodable {
    case string(String)
    case bool(Bool)
    case int(Int)
    case double(Double)
    case array([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else if let int = try? container.decode(Int.self) {
            self = .int(int)
        } else if let double = try? container.decode(Double.self) {
            self = .double(double)
        } else if let strings = try? container.decode(Array<String>.self) {
            self = .array(strings)
        } else {
            throw NetworkingError.encoding
        }
    }
}

extension HTTPParameter {

    var url: URL? {
        switch self {
        case .string(let value):
            return URL(string: value)
        default:
            return nil
        }
    }

    var string: String? {
        switch self {
        case .string(let value):
            return value
        default:
            return nil
        }
    }
}
