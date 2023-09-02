//
//  AuthorizationStrategyProvider.swift
//  
//
//  Created by Ostap Holub on 23.02.2023.
//

import Foundation

public protocol AuthorizationStrategyProvider {

    func makeStrategy(_ type: Authorization) -> AuthorizationStrategy
}

public final class AlwaysNoAuthorizationProvider: AuthorizationStrategyProvider {

    public init() {}

    public func makeStrategy(_ type: Authorization) -> AuthorizationStrategy {
        NoAuthorizationStrategy()
    }
}
