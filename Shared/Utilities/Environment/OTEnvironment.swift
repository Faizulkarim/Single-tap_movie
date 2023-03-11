//
//  OTEnvironment.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 1/3/23.
//

import Foundation

/// Environment.
///
/// - dev: Dev.
/// - staging: Staging.
/// - production: Production.
public enum OTEnvironment: String {
    case dev = "Dev"
    case staging = "Staging"

    
    /// All environments.
    ///
    /// - Returns: All environments.
    public static func allEnvironments() -> [OTEnvironment] {
        return [.dev, .staging]
    }
    
    /// API key for the environment.
    ///
    /// - Returns: API key.
    public func apiKey() -> String {
        switch self {
        case .dev:
            return ""
        case .staging:
            return ""

        }
    }
    
    /// Base URL for the environment.
    ///
    /// - Returns: Base URL.
    public func baseURLString(apiEndPoint: APIEndpoint) -> String  {
        switch apiEndPoint {
        default :
            switch self {
            case .dev:
                return Constants.kDEV
            case .staging:
                return Constants.kDEV
            }
        }
        
    }
}
