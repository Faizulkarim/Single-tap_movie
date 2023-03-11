//
//  APIEndpoint.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import Foundation


public enum APIEndpoint {
    
    case movieList(params: Parameters)
    
    
}
extension APIEndpoint: EndPointType {
    
    var environmentBaseURL : String {
        return getAppEnvironment().baseURLString(apiEndPoint: self)
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .movieList:
            return "/search/movie"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .movieList:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .movieList(let params):
          return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: params, additionHeaders: headers)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self  {
        case .movieList:
            return nil
        }
    }
    
}
