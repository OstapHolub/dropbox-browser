//
// FileUpload.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

public enum FileUpload {

    public enum Key: String {
        case boundary = "boundary"
        case fileURL = "url"
        case filename = "filename"
    }
}
