//
// URL+MimeType.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation
import UniformTypeIdentifiers

public extension URL {

    var mimeType: String {
        if let mimeType = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
            return mimeType
        } else {
            return "application/octet-stream"
        }
    }
}
