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

    private let codeVerifier: String
    private let codeChallenge: String
    private let state: String

    init(apiClient: APIClient, urlBuilder: AuthURLBuilder) {
        self.apiClient = apiClient
        self.urlBuilder = urlBuilder

        self.codeVerifier = String.randomCodeVerifier
        self.codeChallenge = self.codeVerifier.codeChallenge
        self.state = "123"

        super.init()
    }

    func authenticate() throws {
        let url = try urlBuilder.build(with: [
            .clientId(Environment.clientId),
            .redirectURL(Environment.authRedirectURI.absoluteString),
            .responseType(Environment.authResponseType),
            .scopes(["account_info.read"]),
            .state(state),
            .codeChallenge(codeChallenge),
            .codeChallengeMethod(Environment.codeChallengeMethod)
        ])

        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: Environment.redirectURIScheme, completionHandler: { url, error in
            print(url)
            print(error)
        })

        session.presentationContextProvider = self
        session.prefersEphemeralWebBrowserSession = true
        session.start()
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
