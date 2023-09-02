//
//  HTTPMethod.swift
//  
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Describes HTTP methods with `String` raw value for `APIRequest` desctiption.
public enum HTTPMethod: String, Encodable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    case head = "HEAD"
}
