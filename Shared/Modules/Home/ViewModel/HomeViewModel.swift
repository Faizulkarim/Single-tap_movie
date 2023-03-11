//
//  HomeViewModel.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import Combine

// MARK: HomeViewModel
final class HomeViewModel {
    
    // MARK: Private variables
    private var disposeBag: DisposeBag = DisposeBag()
    private let apiManager: OTAPIManager
    private var displayModel: HomeDisplayModel = HomeDisplayModel()
   

    // MARK: Init Functions

    /// Initializes the model
    ///
    /// - Parameters:
    ///   - apiManager: APIManager manager.
    init(apiManager: OTAPIManager) {
        self.apiManager = apiManager
    }

    private func viewModels<T>(from models: [T]) -> [HomeDisplayModel] {
        return models.map { HomeDisplayModelBuilder.viewModel(from: $0)}
    }
    
}

// MARK: HomeViewModelType

/// Get HomeViewModelType protocol methods
extension HomeViewModel: HomeViewModelType {

    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: HomeViewModelInput) -> HomeViewModelOutput {
        /// Clear all observer
        disposeBag.cancel()

        // Observe viewDidload event and perform action
        let viewDidLoadPublisher = input.viewDidLoad
            .map({ input -> HomeViewState in
                return .viewDidLoad
                })
            .eraseToAnyPublisher()
        
        let movieListApiPublisher : PassthroughSubject<HomeViewState, Never> = .init()
        input.movieListApiSubject.flatMap { requestModel -> AnyPublisher<Result<MovieListAPIResponseModel?, OTError>, Never> in
            movieListApiPublisher.send(.loading(shouldShow: true))
            return self.apiManager.getMovieList(requestModel)
        }.sink { result in
            DispatchQueue.main.async {
                movieListApiPublisher.send(.loading(shouldShow: false))
                switch result {
                case .success(let response):
                    print(response)
                    movieListApiPublisher.send(.apiSuccess(response: response))
                case .failure(let error):
                    movieListApiPublisher.send(.apiFailure(customError: error))
                }
            }
        }.store(in: disposeBag)


        let viewDidLoadAndLoadDataPublisher = Publishers.MergeMany(viewDidLoadPublisher,movieListApiPublisher.eraseToAnyPublisher()).eraseToAnyPublisher()

        

        // If there any service call during view load so call it and
        // return success with response model or just return empty
        // response with success call as below
        return HomeViewModelOutput.init(viewState: viewDidLoadAndLoadDataPublisher)
    }

}
