//
//  AuthViewModel.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

final class AuthViewModel: NSObject {

    private let authService: AuthServiceProtocol
    private let credentialsStore: CredentialsStoreProtocol

    init(authService: AuthServiceProtocol, credentialsStore: CredentialsStoreProtocol) {
        self.authService = authService
        self.credentialsStore = credentialsStore
    }

    func authenticate() async {
        do {
            let authResult = try await authService.startAuthentication()
            let credentials = try await authService.exchange(code: authResult.code,
                                                             state: authResult.state)

            credentialsStore.save(credentials)
        } catch {

        }
    }
}
