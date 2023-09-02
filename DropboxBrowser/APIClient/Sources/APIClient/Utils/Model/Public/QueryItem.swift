//
// QueryItem.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Describes a generic query item for URL building purposes.
public protocol QueryItem {

    /// Name of the query parameter
    var name: String { get }

    /// Value of the query parameter
    var value: String { get }
}
