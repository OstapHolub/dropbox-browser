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

final class AlwaysNoAuthorizationProvider: AuthorizationStrategyProvider {

    func makeStrategy(_ type: Authorization) -> AuthorizationStrategy {
        NoAuthorizationStrategy()
    }
}
