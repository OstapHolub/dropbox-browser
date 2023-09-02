//
// HTTPErrorPayload.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Describes uniform response from server for not success status codes.
public struct HTTPErrorPayload: Codable {

    public let success: Bool

    public let error: NeuralError

    public var message: String {
        error.message
    }
}

public struct NeuralError: Codable {
    let type: String
    let message: String
    let httpCode: Int
    let eventCode: Int

    enum CodingKeys: String, CodingKey {
        case type
        case message
        case httpCode = "http_code"
        case eventCode = "event_code"
    }
}
