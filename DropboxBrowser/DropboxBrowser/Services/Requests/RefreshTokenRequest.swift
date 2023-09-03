//
//  RefreshTokenRequest.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 03.09.2023.
//

import Foundation
import APIClient

struct RefreshTokenRequest: APIRequest {

    typealias Response = Credentials

    let grantType: String = "refresh_token"
    let refreshToken: String
    let clientId: String

    var resourceName: String {
        "token"
    }

    var method: HTTPMethod {
        .post
    }

    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case refreshToken = "refresh_token"
        case clientId = "client_id"
    }
}
