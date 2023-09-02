//
//  AuthService.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation
import APIClient
import AuthenticationServices

final class AuthService: NSObject, AuthServiceProtocol {

    private let apiClient: APIClient
    private let urlBuilder: AuthURLBuilder

    init(apiClient: APIClient, urlBuilder: AuthURLBuilder) {
        self.apiClient = apiClient
        self.urlBuilder = urlBuilder
        super.init()
    }

    func authenticate() {

    }

    func exchange(code: String) {

    }

    func refresh(token: String) {

    }
}

extension AuthService: ASWebAuthenticationPresentationContextProviding {

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}
