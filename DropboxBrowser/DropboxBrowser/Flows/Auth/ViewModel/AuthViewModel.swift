//
//  AuthViewModel.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation
import AuthenticationServices

final class AuthViewModel: NSObject {

    func authenticate() {
        let session = ASWebAuthenticationSession(url: Environment.baseAuthURL, callbackURLScheme: "") { url, error in
            print(url)
            print(error)
        }
        session.presentationContextProvider = self
        session.prefersEphemeralWebBrowserSession = true
        session.start()
    }
}

extension AuthViewModel: ASWebAuthenticationPresentationContextProviding {

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}
