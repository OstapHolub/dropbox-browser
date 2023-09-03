//
//  AuthQueryItem.swift
//  
//
//  Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Public authentication URL query parameters. Use this enumeration to
/// build custom authentication URL to fit your needs.
public enum AuthQueryItem: QueryItem {

    public var name: String {
        switch self {
        case .scopes: return "scopes"
        case .redirectURL: return "redirect_uri"
        case .responseType: return "response_type"
        case .state: return "state"
        case .clientId: return "client_id"
        case .codeChallenge: return "code_challenge"
        case .codeChallengeMethod: return "code_challenge_method"
        case .tokenAccessType: return "token_access_type"
        }
    }

    public var value: String {
        switch self {
        case let .scopes(scopes): return scopes.joined(separator: ",")
        case let .redirectURL(redirectURI): return redirectURI
        case let .responseType(type): return type
        case let .state(state): return state
        case let .clientId(id): return id
        case let .codeChallenge(challenge): return challenge
        case let .codeChallengeMethod(method): return method
        case let .tokenAccessType(type): return type
        }
    }

    case scopes([String])
    case redirectURL(String)
    case responseType(String)
    case state(String)
    case clientId(String)
    case codeChallenge(String)
    case codeChallengeMethod(String)
    case tokenAccessType(String)
}
