//
// MocksRegistry.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Registry provides a place to hold mocked response data for
/// HTTP requests based on `APIRequest` implmentation.
public enum MocksRegistry {

    /// Registration of mock response data is happening using `add(mockData: Data, for request: APIRequest)`
    /// or the same method registering result error. Registration key is the request `URL`.
    static var registry: [URLRequest: Result<Data, Error>] = [:]

    /// Adds mock data entry to the `registry`.
    /// - Parameters:
    ///     - mockData: Mocked piece of data as a response to request.
    ///     - request: Implementation of `APIRequest` protocol. Used for registry key generation.
    public static func add<T: APIRequest>(mockData: Data, for request: T) {
        let requestBuilder = URLRequestBuilder(authorizationProvider: AlwaysNoAuthorizationProvider())

        do {
            let urlRequest = try requestBuilder.makeRequest(request, baseURL: URL(fileURLWithPath: ""))
            registry[urlRequest] = .success(mockData)
        } catch {
            print("Failed registering \(request) due to error: \(error)")
        }
    }

    /// Adds mock data entry to the `registry`.
    /// - Parameters:
    ///    - mockError: Mocked piece of error as a response to request.
    ///    - request: Implementation of `APIRequest` protocol. Used for registry key generation.
    public static func add<T: APIRequest>(mockError: Error, for request: T) {
        let requestBuilder = URLRequestBuilder(authorizationProvider: AlwaysNoAuthorizationProvider())

        do {
            let urlRequest = try requestBuilder.makeRequest(request, baseURL: URL(fileURLWithPath: ""))
            registry[urlRequest] = .failure(mockError)
        } catch {
            print("Failed registering \(request) due to error: \(error)")
        }
    }

    /// Removes entry data for request.
    /// - Parameters:
    ///    - request: Implementation of `APIRequest` protocol. Used for registry key generation.
    public static func remove<T: APIRequest>(request: T) {
        let requestBuilder = URLRequestBuilder(authorizationProvider: AlwaysNoAuthorizationProvider())

        do {
            let urlRequest = try requestBuilder.makeRequest(request, baseURL: URL(fileURLWithPath: ""))
            registry.removeValue(forKey: urlRequest)
        } catch {
            print("Failed registering \(request) due to error: \(error)")
        }
    }

    /// Determines wether registry contains specific instance of `URLRequest`.
    /// - Parameter request: Instance of `URLRequest` to look for.
    /// - Returns: `True` if registry contains such request, `false` otherwise.
    public static func contains(_ request: URLRequest) -> Bool {
        MocksRegistry.registry.contains(where: { $0.key.url == request.url && $0.key.httpMethod == request.httpMethod })
    }

    /// Looks for the response data for specific instance of `URLRequest`.
    /// - Parameter request: Instance of `URLRequest` to look for.
    /// - Returns: Instance of `Result` with registered `Data` or `Error`.
    public static func response(for request: URLRequest) -> Result<Data, Error>? {
        registry.first(where: { $0.key.url == request.url
            && $0.key.httpMethod == request.httpMethod
        })?.value
    }
}
