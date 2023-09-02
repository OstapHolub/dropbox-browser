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

    static func makeModule() -> AnyView {

        let requestBuilder = URLRequestBuilder(authorizationProvider: AlwaysNoAuthorizationProvider())
        let uploadBuilder = UploadRequestBuilder(authorizationProvider: AlwaysNoAuthorizationProvider())

        let apiClient = URLSessionClient(requestBuilder: requestBuilder,
                                         uploadBuilder: uploadBuilder,
                                         baseURL: Environment.baseAuthURL)

        let urlBuilder = AuthURLBuilder(url: Environment.baseAuthURL)
        let authService = AuthService(apiClient: apiClient, urlBuilder: urlBuilder)
        let viewModel = AuthViewModel(authService: authService)
        return AnyView(AuthView(viewModel: viewModel))
    }
}
