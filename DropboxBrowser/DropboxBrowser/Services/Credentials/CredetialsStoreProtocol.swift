//
//  CredetialsStoreProtocol.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 03.09.2023.
//

import Foundation

protocol CredentialsStoreProtocol {

    var token: String? { get }
    var refreshToken: String? { get }
    var isTokenExpired: Bool { get }

    func save(_ credentials: Credentials)
    func clear()
}
