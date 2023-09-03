//
//  URL+State.swift
//  DropboxBrowser
//
//  Created by Ostap Holub on 03.09.2023.
//

import Foundation

extension URL {
    var state: String? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        return components.queryItems?.first(where: { $0.name == "state" })?.value
    }
}
