//
//  AuthStateService.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 03.09.2023.
//

import Foundation

final class AuthStateService: ObservableObject {

    @Published var state: AuthState
    private let credentialsStore: CredentialsStoreProtocol

    init(credentialsStore: CredentialsStoreProtocol) {
        self.credentialsStore = credentialsStore

        if credentialsStore.isTokenExpired {
            self.state = .expired
        } else if credentialsStore.token != nil {
            self.state = .authenticated
        } else {
            self.state = .anonymous
        }
    }
}
