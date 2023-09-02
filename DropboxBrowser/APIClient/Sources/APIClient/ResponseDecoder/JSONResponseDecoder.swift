//
// JSONResponseDecoder.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

struct JSONResponseDecoder: ResponseDecoder {

    let decoder: JSONDecoder

    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        return try decoder.decode(type, from: data)
    }
}
