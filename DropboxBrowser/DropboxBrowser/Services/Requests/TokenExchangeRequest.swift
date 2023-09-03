//
//  TokenExchangeRequest.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation
import APIClient

struct TokenExchangeRequest: APIRequest {

    typealias Response = Credentials

    let code: String
    let grantType: String
    let redirectURI: String
    let clientId: String
    let codeVerifier: String

    var resourceName: String {
        "oauth2/token"
    }

    var method: HTTPMethod {
        .post
    }

    enum CodingKeys: String, CodingKey {
        case code
        case grantType = "grant_type"
        case redirectURI = "redirect_uri"
        case clientId = "client_id"
        case codeVerifier = "code_verifier"
    }
}
