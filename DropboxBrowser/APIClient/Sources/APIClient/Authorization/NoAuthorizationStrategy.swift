//
//  NoAuthorizationStrategy.swift
//  
//
//  Created by Ostap Holub on 23.02.2023.
//

import Foundation

public final class NoAuthorizationStrategy: AuthorizationStrategy {

    public init() {}

    public var value: String? {
        nil
    }
}
