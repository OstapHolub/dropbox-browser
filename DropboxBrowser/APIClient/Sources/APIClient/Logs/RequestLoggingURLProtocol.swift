//
// RequestLoggingURLProtocol.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Defines `URLProtocol` responsible for logging all API requests
public class RequestLoggingURLProtocol: URLProtocol {

    public override class func canInit(with request: URLRequest) -> Bool {
        let logMessage =
                        """
                        --- Log Start ---
                        Loading of request started.
                        URL: \(request.url?.absoluteString ?? "No URL found")
                        HTTP Method: \(request.httpMethod ?? "No Method found")
                        HTTP Body: \(request.httpBody == nil ? "No Body found" : String(data: request.httpBody!, encoding: .utf8)!)
                        --- Log End ---
                        """
        print(logMessage)
        return false
    }
}
