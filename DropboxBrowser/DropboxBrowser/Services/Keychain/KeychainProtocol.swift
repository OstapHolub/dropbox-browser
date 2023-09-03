//
// KeychainProtocol.swift
// DropboxBrowser
//

// Created by Ostap Holub on 03.09.2023.
//

import Foundation

/// Defines protocol for Keychain communication including CRUD operations.
public protocol KeychainProtocol {

    func save(_ data: Any, forKey: String) -> Bool
    func value(forKey: String) -> Any?
    func remove(forKey: String) -> Bool
}
