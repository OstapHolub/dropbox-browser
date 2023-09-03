//
//  Credentials.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 03.09.2023.
//

import Foundation

struct Credentials: Codable {
    let accessToken: String
    let expiresIn: Int
    let tokenType: String
    let scope: String
    let accountId: String?
    let teamId: String?
    let refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case scope
        case accountId = "account_id"
        case teamId = "team_id"
        case refreshToken = "refresh_token"
    }
}
