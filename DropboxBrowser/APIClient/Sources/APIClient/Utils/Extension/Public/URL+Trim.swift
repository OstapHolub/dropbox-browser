//
// URL+Trim.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

public extension URL {

    var removingQueries: URL {
        if var components = URLComponents(string: absoluteString) {
            components.query = nil
            return components.url ?? self
        } else {
            return self
        }
    }
}
