//
// URL+Auth.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

extension URL {

    var urlComponents: URLComponents? {
        return URLComponents(url: self, resolvingAgainstBaseURL: false)
    }
}

public extension URL {

    var error: AuthError? {
        guard let errorKey = urlComponents?.queryItems?.first(where: { $0.name == "error" })?.value,
              let errorDescription = urlComponents?.queryItems?.first(where: { $0.name == "error_description" })?.value else {
            return nil
        }

        return AuthError.makeError(key: errorKey, message: errorDescription)
    }

    var accountId: String? {
        return urlComponents?
            .queryItems?.first(where: { $0.name == "account_id" })?
            .nonEmptyValue
    }

    var accessToken: String? {
        return urlComponents?.queryItems?.first(where: { $0.name == "access_token" })?.nonEmptyValue
    }

    var provider: String? {
        return urlComponents?.queryItems?.first(where: { $0.name == "provider" })?.nonEmptyValue
    }

    var email: String? {
        return urlComponents?.queryItems?.first(where: { $0.name == "email_address" })?.nonEmptyValue
    }
}
