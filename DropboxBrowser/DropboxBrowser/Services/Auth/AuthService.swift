//
//  AuthService.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation
import APIClient

final class AuthService {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func authenticate() {

    }

    func exchangeToken(code: String) {

    }

    func refreshToken(_ refreshToken: String) {

    }
}
