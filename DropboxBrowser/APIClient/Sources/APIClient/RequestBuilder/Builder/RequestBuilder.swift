//
// RequestBuilder.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

public protocol RequestBuilder {

    func makeRequest<T: APIRequest>(_ apiRequest: T, baseURL: URL) throws -> URLRequest
}
