//
// RFC822ResponseDecoder.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

struct RFC822ResponseDecoder: ResponseDecoder {

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        guard let responseString = String(data: data, encoding: .utf8) as? T else {
            fatalError("Response should be string!")
        }
        return responseString
    }

}
