//
//  Environment.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

enum Environment {

    static let baseURL: URL = {
        guard var urlString = Environment.infoDictionary[Key.baseURL] as? String else {
            fatalError("\(Key.baseURL) key not set in plist for this environment")
        }
        urlString = urlString.replacingOccurrences(of: "\\", with: "")

        guard let url = URL(string: urlString) else {
            fatalError("\(Key.baseURL) value is not a valid URL")
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
        static let baseURL = "DROPBOX_BASE_URL"
        static let clientId = "DROPBOX_CLIENT_ID"
    }
}
