//
// AuthURLBuilder.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

public struct AuthURLBuilder {

    let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func build(with query: [AuthQueryItem]) throws -> URL {

        guard !query.isEmpty else {
            throw URLBuilderError.emptyParams
        }

        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLBuilderError.invalidBaseURL
        }

        components.queryItems = query.map { URLQueryItem(name: $0.name, value: $0.value) }

        guard let url = components.url else {
            throw URLBuilderError.invalidResult
        }

        return url
    }
}
