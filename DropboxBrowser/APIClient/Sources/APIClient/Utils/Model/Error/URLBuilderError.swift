//
// URLBuilderError.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

public enum URLBuilderError: Error {
    case invalidBaseURL
    case invalidResult
    case emptyParams
}
