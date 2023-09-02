//
//  AuthServiceProtocol.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

protocol AuthServiceProtocol {

    func authenticate() throws
    func exchange(code: String)
    func refresh(token: String)
}
