//
//  Environment.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

enum Environment {

    static let baseAPIURL: URL = {
        guard var urlString = Environment.infoDictionary[Key.baseAPIURL] as? String else {
            fatalError("\(Key.baseAPIURL) key not set in plist for this environment")
        }
        urlString = urlString.replacingOccurrences(of: "\\", with: "")

        guard let url = URL(string: urlString) else {
            fatalError("\(Key.baseAPIURL) value is not a valid URL")
        }
        return url
    }()

    static let baseAuthURL: URL = {
        guard var urlString = Environment.infoDictionary[Key.baseAuthURL] as? String else {
            fatalError("\(Key.baseAuthURL) key not set in plist for this environment")
        }
        urlString = urlString.replacingOccurrences(of: "\\", with: "")

        guard let url = URL(string: urlString) else {
            fatalError("\(Key.baseAuthURL) value is not a valid URL")
        }
        return url
    }()

    static let clientId: String = {
        guard let value = Environment.infoDictionary[Key.clientId] as? String else {
            fatalError("\(Key.clientId) key not set in plist for this environment")
        }
        return value
    }()
}

// MARK: - Private methods
private extension Environment {

    static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
}

private extension Environment {

    enum Key {
        static let baseAPIURL = "BASE_API_URL"
        static let baseAuthURL = "BASE_AUTH_URL"
        static let clientId = "CLIENT_ID"
    }
}
