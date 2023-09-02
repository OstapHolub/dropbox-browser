//
// ResponseDecoder.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Prorocol describing process of decoding objects from `Data`.
protocol ResponseDecoder {

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}
