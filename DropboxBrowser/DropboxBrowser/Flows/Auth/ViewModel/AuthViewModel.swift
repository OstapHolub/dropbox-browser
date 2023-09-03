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
    private let authStateService: AuthStateService

    init(authService: AuthServiceProtocol, credentialsStore: CredentialsStoreProtocol, authStateService: AuthStateService) {
        self.authService = authService
        self.credentialsStore = credentialsStore
        self.authStateService = authStateService
    }

    func authenticate() async {
        do {
            let authResult = try await authService.startAuthentication()
            let credentials = try await authService.exchange(code: authResult.code,
                                                             state: authResult.state)

            credentialsStore.save(credentials)
            authStateService.state = .authenticated
        } catch {

        }
    }
}
