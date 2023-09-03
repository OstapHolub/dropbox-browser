//
//  AuthAssembly.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation
import SwiftUI
import APIClient

enum AuthAssembly {

    static func makeModule(authStateService: AuthStateService) -> AnyView {

        let requestBuilder = URLRequestBuilder(authorizationProvider: AlwaysNoAuthorizationProvider())
        let uploadBuilder = UploadRequestBuilder(authorizationProvider: AlwaysNoAuthorizationProvider())

        let apiClient = URLSessionClient(requestBuilder: requestBuilder,
                                         uploadBuilder: uploadBuilder,
                                         baseURL: Environment.baseAPIURL)

        let urlBuilder = AuthURLBuilder(url: Environment.baseAuthURL)
        let authService = AuthService(apiClient: apiClient,
                                      urlBuilder: urlBuilder)
        let credentialsStore = CredentialsStore(keychain: Keyсhain())

        let viewModel = AuthViewModel(authService: authService,
                                      credentialsStore: credentialsStore,
                                      authStateService: authStateService)
        return AnyView(AuthView(viewModel: viewModel))
    }
}
