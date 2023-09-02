//
// URLSessionConfigurationBuilder.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Custom `URLSessionConfiguration` builder deisgned to add headers and
/// custom implementations of `URLProtocol`.
public class URLSessionConfigurationBuilder {

    /// `URLSessionConfiguration` to be updated.
    private let config: URLSessionConfiguration

    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.config = configuration
    }

    /// Adds single key-value header to configurations' `httpAdditionalHeaders` property.
    /// - Parameters:
    ///   - key: Headers's key to be stored.
    ///   - value: Header's value to be stored.
    /// - Returns: Instance of builder in order to continue building process.
    public func additionalHeader(_ key: AnyHashable, value: Any) -> URLSessionConfigurationBuilder {
        guard config.httpAdditionalHeaders != nil else {
            config.httpAdditionalHeaders = [key: value]
            return self
        }
        config.httpAdditionalHeaders?[key] = value
        return self
    }

    /// Addes multiple key-value headers to configurations' `httpAdditionalHeaders` property.
    /// - Parameter headers: Dictionary of key-value headers to be stored.
    /// - Returns: Instance of builder in order to continue building process.
    public func additionalHeaders(_ headers: [AnyHashable: Any]) -> URLSessionConfigurationBuilder {
        guard config.httpAdditionalHeaders != nil else {
            config.httpAdditionalHeaders = headers
            return self
        }
        headers.forEach {
            config.httpAdditionalHeaders?[$0.key] = $0.value
        }
        return self
    }

    /// Adds single `URLProtocol` class to configuration's `protocolClasses` property.
    /// - Parameter protocolClass: `URLProtocol` implementation type to be stored.
    /// - Returns: Instance of builder in order to continue building process.
    public func requestProtocol(_ protocolClass: AnyClass) -> URLSessionConfigurationBuilder {
        guard config.protocolClasses?.isEmpty == false else {
            config.protocolClasses = [protocolClass]
            return self
        }
        config.protocolClasses?.insert(protocolClass, at: 0)
        return self
    }

    /// Adds multiple `URLProtocol` classes to configuration's `protocolClasses` property.
    /// - Parameter protocolClasses: `URLProtocol` implementation types array to be stored.
    /// - Returns: Instance of builder in order to continue building process.
    public func requestProtocols(_ protocolClasses: [AnyClass]) -> URLSessionConfigurationBuilder {
        guard let classes = config.protocolClasses else {
            config.protocolClasses = protocolClasses
            return self
        }
        config.protocolClasses = protocolClasses + classes
        return self
    }

    /// Builds an instance of `URLSessionConfiguration`.
    /// - Returns: Configured with previously stored headers and protocol classes configuration.
    public func build() -> URLSessionConfiguration {
        config
    }
}
