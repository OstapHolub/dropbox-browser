//
// URLQueryItem+Fallback.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

public extension URLQueryItem {

    var nonEmptyValue: String? {
        return value == "" ? nil : value
    }
}
