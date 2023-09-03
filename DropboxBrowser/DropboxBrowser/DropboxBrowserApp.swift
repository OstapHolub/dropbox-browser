//
//  DropboxBrowserApp.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import SwiftUI
import APIClient

@main
struct DropboxBrowserApp: App {

    @StateObject var authStateService =
        AuthStateService(credentialsStore: CredentialsStore(keychain: Keyсhain()))

    var body: some Scene {
        WindowGroup {
            if authStateService.state == .authenticated {
                ContentView()
            } else {
                AuthAssembly.makeModule(authStateService: authStateService)
            }
        }
    }
}
