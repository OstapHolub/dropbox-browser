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

    var body: some Scene {
        WindowGroup {
            AuthAssembly.makeModule()
        }
    }
}
