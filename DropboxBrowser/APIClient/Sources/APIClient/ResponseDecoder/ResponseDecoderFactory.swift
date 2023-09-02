//
// ResponseDecoderFactory.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

enum ResponseDecoderFactory {

    static func makeDecoder(for headers: [AnyHashable: Any]) -> ResponseDecoder {
        guard let contentType = headers["Content-Type"] as? String else {
            return JSONResponseDecoder()
        }

        if contentType == "message/rfc822" {
            return RFC822ResponseDecoder()
        } else {
            return JSONResponseDecoder()
        }
    }

}
