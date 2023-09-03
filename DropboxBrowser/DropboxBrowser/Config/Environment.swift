//
//  Environment.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

enum Environment {

    // General

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

    static let clientId: String = {
        guard let value = Environment.infoDictionary[Key.clientId] as? String else {
            fatalError("\(Key.clientId) key not set in plist for this environment")
        }
        return value
    }()

    // Authentication

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

    static let redirectURIScheme: String = {
        guard let value = Environment.infoDictionary[Key.authRedirectURIScheme] as? String else {
            fatalError("\(Key.authRedirectURIScheme) key not set in plist for this environment")
        }
        return value
    }()

    static let authResponseType: String = {
        guard let value = Environment.infoDictionary[Key.authResponseType] as? String else {
            fatalError("\(Key.authResponseType) key not set in plist for this environment")
        }
        return value
    }()

    static let authRedirectURI: URL = {
        guard var urlString = Environment.infoDictionary[Key.authRedirectURI] as? String else {
            fatalError("\(Key.authRedirectURI) key not set in plist for this environment")
        }
        urlString = urlString.replacingOccurrences(of: "\\", with: "")

        guard let url = URL(string: urlString) else {
            fatalError("\(Key.authRedirectURI) value is not a valid URL")
        }
        return url
    }()

    static let codeChallengeMethod: String = {
        guard let value = Environment.infoDictionary[Key.codeChallengeMethod] as? String else {
            fatalError("\(Key.codeChallengeMethod) key not set in plist for this environment")
        }
        return value
    }()

    static let tokenAccessType: String = {
        guard let value = Environment.infoDictionary[Key.tokenAccessType] as? String else {
            fatalError("\(Key.tokenAccessType) key not set in plist for this environment")
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
        static let authRedirectURIScheme = "AUTH_REDIRECT_URI_SCHEME"
        static let authRedirectURI = "AUTH_REDIRECT_URI"
        static let authResponseType = "AUTH_RESPONSE_TYPE"
        static let codeChallengeMethod = "AUTH_CODE_CHALLENGE_METHOD"
        static let baseAuthURL = "AUTH_BASE_URL"
        static let clientId = "CLIENT_ID"
        static let tokenAccessType = "AUTH_TOKEN_ACCESS_TYPE"
    }
}
