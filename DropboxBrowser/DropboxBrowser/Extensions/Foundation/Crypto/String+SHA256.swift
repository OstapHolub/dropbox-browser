//
//  String+SHA256.swift
//  AuthDemoApp
//
//  Created by Ostap Holub on 17.02.2022.
//

import Foundation

extension String {
    var sha256: String {
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.sha256
        }
        return ""
    }
}
