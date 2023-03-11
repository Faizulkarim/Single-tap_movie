//
//  OTAPIManager.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import Foundation
import Combine

struct OTAPIManager {
    /// Router to call custom get/post request via Middleware
    let router: Router<APIEndpoint> = Router<APIEndpoint>()
}

// ----------------------------------
// MARK: - Middleware Calls
//

extension OTAPIManager {
    @discardableResult
    func getMovieList(_ parmas: Parameters) -> AnyPublisher<Result<MovieListAPIResponseModel?, OTError>, Never> {
        return Deferred {
            Future { promise in
                self.router.request(APIEndpoint.movieList(params: parmas)) { data, _ , error in
                    print(data)
                    if let error = error {
                        promise(.success(Result.failure(OTError(fromError: error as NSError))))
                    } else {
                        if let validResponse = MovieListAPIResponseModel.decode(data: data) {
                                promise(.success(Result.success(validResponse)))
                        } else {
                            let customError = OTError(statusCode: -1, title: LocalizationKey.NetworkError.parsingError.value(),body: LocalizationKey.NetworkError.parsingErrorDes.value())
                            promise(.success(Result.failure(customError)))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}


struct OTErrorArray: Codable {
    var errors: [OTError]?
    
    enum CodingKeys: String, CodingKey {
        case errors
    }
}

struct OTError: Error, Codable {
    var statusCode: Int?
    var title: String?
    var body: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case title
        case body
    }
}

extension OTError {
    
    init(fromError: NSError) {
        self.init()
        self.statusCode = fromError.code
        if fromError.code == NSURLErrorNotConnectedToInternet || fromError.code == NSURLErrorNetworkConnectionLost  || fromError.code == 503 {
            self.title = LocalizationKey.NetworkError.ConnectionLostTitle.value()
            self.body = LocalizationKey.NetworkError.ConnectionLostDesc.value()
        } else if fromError.code == NSURLErrorBadURL {
            self.title = LocalizationKey.NetworkError.InvalidUrlTitle.value()
            self.body = LocalizationKey.NetworkError.InvalidUrlDesc.value()
        } else{
            self.title = fromError.localizedDescription
            self.body = fromError.localizedRecoverySuggestion
        }
    }
    
    init(statusCode: Int, title: String, body: String) {
        self.statusCode = statusCode
        self.title = title
        self.body = body
    }
}

