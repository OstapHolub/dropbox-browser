//
//  Data+Base64.swift
//  AuthDemoApp
//
//  Created by Ostap Holub on 17.02.2022.
//

import Foundation

extension Data {

    var base64EncodedStringRemovedPadding: String? {
        base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
            .trimmingCharacters(in: .whitespaces)
    }
}
