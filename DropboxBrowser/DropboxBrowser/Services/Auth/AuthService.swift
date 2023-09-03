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

    func startAuthentication() async throws -> (state: String, code: String) {
        let url = try urlBuilder.build(with: [
            .clientId(Environment.clientId),
            .redirectURL(Environment.authRedirectURI.absoluteString),
            .responseType(Environment.authResponseType),
            .scopes(["account_info.read"]),
            .state(state),
            .codeChallenge(codeChallenge),
            .codeChallengeMethod(Environment.codeChallengeMethod),
            .tokenAccessType(Environment.tokenAccessType)
        ])

        return try await withCheckedThrowingContinuation { continuation in
            let session = ASWebAuthenticationSession(url: url,
                                                     callbackURLScheme: Environment.redirectURIScheme,
                                                     completionHandler: { url, error in

                if let error = error {
                    continuation.resume(throwing: error)
                }

                guard let state = url?.state,
                      let code = url?.code else {
                    continuation.resume(throwing: AuthError.unknown(""))
                    return
                }

                continuation.resume(returning: (state, code))
            })
            session.presentationContextProvider = self
            session.prefersEphemeralWebBrowserSession = true
            session.start()
        }
    }

    func authenticate() async throws { }

    func exchange(code: String, state: String) async throws -> Credentials {
        guard self.state == state else {
            fatalError()
        }

        let request = TokenExchangeRequest(code: code,
                                           grantType: "authorization_code",
                                           redirectURI: Environment.authRedirectURI.absoluteString,
                                           clientId: Environment.clientId,
                                           codeVerifier: codeVerifier)

        return try await apiClient.send(request)
    }

    func refresh(token: String) async throws -> Credentials {
        let request = RefreshTokenRequest(refreshToken: token,
                                          clientId: Environment.clientId)
        return try await apiClient.send(request)
    }
}

extension AuthService: ASWebAuthenticationPresentationContextProviding {

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}
