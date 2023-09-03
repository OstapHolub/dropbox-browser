//
//  String+Auth.swift
//  AuthDemoApp
//
//  Created by Ostap Holub on 17.02.2022.
//

import Foundation
import CommonCrypto

extension String {

    static var randomCodeVerifier: String {
        var buffer = [UInt8](repeating: 0, count: 32)
        _ = SecRandomCopyBytes(kSecRandomDefault, buffer.count, &buffer)
        let codeVerifier = Data(buffer).base64EncodedStringRemovedPadding

        return codeVerifier ?? ""
    }

    var codeChallenge: String {
        sha256
            .data(using: .utf8)?
            .base64EncodedStringRemovedPadding ?? ""
    }
}
