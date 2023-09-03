//
//  CredentialsStore.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 03.09.2023.
//

import Foundation

final class CredentialsStore: CredentialsStoreProtocol {

    /// Private enumaration of keys for storage.
    private enum Key {
        static let accessToken = "kAccessToken"
        static let refreshToken = "kRefreshToken"
        static let expiresAt = "kExpiresAt"
    }

    private let keychain: KeychainProtocol

    init(keychain: KeychainProtocol) {
        self.keychain = keychain
    }

    var token: String? {
        keychain.value(forKey: Key.accessToken) as? String
    }

    var refreshToken: String? {
        keychain.value(forKey: Key.refreshToken) as? String
    }

    var isTokenExpired: Bool {
        guard let expiresAt = keychain.value(forKey: Key.accessToken) as? Int else {
            return true
        }

        let currentTimestamp = Int(Date().timeIntervalSince1970)
        return currentTimestamp >= expiresAt
    }

    func save(_ credentials: Credentials) {
        _ = keychain.save(credentials.accessToken, forKey: Key.accessToken)
        _ = keychain.save(credentials.refreshToken ?? "", forKey: Key.accessToken)
        let expiresAt = Int(Date().timeIntervalSince1970) + credentials.expiresIn
        _ = keychain.save(expiresAt, forKey: Key.expiresAt)
    }

    func clear() {
        _ = keychain.remove(forKey: Key.accessToken)
        _ = keychain.remove(forKey: Key.refreshToken)
        _ = keychain.remove(forKey: Key.expiresAt)
    }
}
