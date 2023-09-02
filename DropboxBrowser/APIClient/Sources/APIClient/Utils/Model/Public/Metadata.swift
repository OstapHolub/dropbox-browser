//
//  Metadata.swift
//  
//
//  Created by Ostap Holub on 23.02.2023.
//

import Foundation

/// Convenience typealias for Dictionary type.
public typealias Metadata = [String: AnyCodable]

public extension Metadata {

    var JSONString: String {
        do {
            let data = try JSONSerialization.data(withJSONObject: self)
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
}
