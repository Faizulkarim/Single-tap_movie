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
    case beta = "Beta"
    case production = "Production"
    
    /// All environments.
    ///
    /// - Returns: All environments.
    public static func allEnvironments() -> [OTEnvironment] {
        return [.dev, .staging, .beta, .production]
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
        case .beta:
            return ""
        case .production:
            return ""
        }
    }
    
    /// Base URL for the environment.
    ///
    /// - Returns: Base URL.
    public func baseURLString(apiEndPoint: APIEndpoint) -> String  {
        switch apiEndPoint {
//        case .googleMapAPIS:
//            return Constants.kGMAPS
        default :
            switch self {
            case .dev:
                return Constants.kDEV
            case .staging:
                return Constants.kUAT
            case .beta:
                return Constants.kBETA
            case .production:
                return Constants.kPROD
            }
        }
        
    }
}
