//
//  AuthView.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 02.09.2023.
//

import SwiftUI

struct AuthView: View {

    let viewModel: AuthViewModel

    var body: some View {
        Button("Auth", action: {
            viewModel.authenticate()
        })
    }
}

struct AuthView_Previews: PreviewProvider {

    static var previews: some View {
        AuthAssembly.makeModule()
    }
}
