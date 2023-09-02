//
//  AuthService.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation
import APIClient

final class AuthService: AuthServiceProtocol {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func authenticate() {

    }

    func exchange(code: String) {

    }

    func refresh(token: String) {

    }
}
