//
//  AuthServiceProtocol.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

protocol AuthServiceProtocol {

    func startAuthentication() async throws -> (state: String, code: String)
    func exchange(code: String, state: String) async throws -> Credentials
    func refresh(token: String) async throws -> Credentials
}
