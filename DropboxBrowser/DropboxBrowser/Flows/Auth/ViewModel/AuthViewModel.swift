//
//  AuthViewModel.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

final class AuthViewModel: NSObject {

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    func authenticate() async {
        do {
            let authResult = try await authService.startAuthentication()
            let credentials = try await authService.exchange(code: authResult.code,
                                                             state: authResult.state)

            //save credentials to store
        } catch {

        }
    }
}
