//
//  AuthorizationStrategy.swift
//  
//
//  Created by Ostap Holub on 23.02.2023.
//

import Foundation

public protocol AuthorizationStrategy {
    var value: String? { get }
}
