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

        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: Environment.redirectURIScheme, completionHandler: { [weak self] url, error in

            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let url = url else {
                return
            }

            guard let state = url.state,
                  let code = url.code else {
                return
            }

            self?.exchange(code: code, state: state)
        })

        session.presentationContextProvider = self
        session.prefersEphemeralWebBrowserSession = true
        session.start()
    }

    func exchange(code: String, state: String) {
        guard self.state == state else {
            return
        }

        let request = TokenExchangeRequest(code: code,
                                           grantType: "authorization_code",
                                           redirectURI: Environment.authRedirectURI.absoluteString,
                                           clientId: Environment.clientId,
                                           codeVerifier: codeVerifier)

        Task {
            let response = try await apiClient.send(request)
            print(response)
        }
    }

    func refresh(token: String) {

    }
}

extension AuthService: ASWebAuthenticationPresentationContextProviding {

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}
