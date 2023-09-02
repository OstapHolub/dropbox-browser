//
// SDKHeader.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Describes key for custom defined SDK headers.
enum SDKHeaderKey: String {

    case sdkName = "User-Agent"
    case sdkVersion = "x-nylas-sdk-verion"
    case deviceIdiom = "x-nylas-device-idiom"
    case systemVersion = "x-system-version"
    case apiVersion = "Nylas-API-Version"
    case contentType = "Content-Type"
}
