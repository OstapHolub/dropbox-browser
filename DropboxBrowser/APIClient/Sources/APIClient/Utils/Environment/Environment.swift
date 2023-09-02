//
// Environment.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all

import Foundation

public enum Environment {
//
//    #if DEBUG
    public static let baseURL: URL = URL(string: "https://neural-parsers-staging.us.nylas.com")!
//    #else
//    public static let baseURL: URL = URL(string: "https://neural-parsers.us.nylas.com")!
//    #endif

    public static let amazonBaseURL: URL = URL(string: "https://www.amazon.com")!

    public static let authURL: URL = {
        return baseURL.appendingPathComponent("oauth/authorize")
    }()
}
