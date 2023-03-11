//
//  HomeViewModelType.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

// MARK: HomeViewModelInput
struct HomeViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let movieListApiSubject : AnyPublisher<Parameters, Never>
}

// MARK: ViewModelOutput
struct HomeViewModelOutput {
    let viewState: AnyPublisher<HomeViewState, Never>
}

// MARK: ViewState
enum HomeViewState {
    case viewDidLoad
    case loading(shouldShow: Bool)
    case apiFailure(customError: OTError)
    case apiSuccess(response: MovieListAPIResponseModel?)
}

// MARK: HomeViewModelType
protocol HomeViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: HomeViewModelInput) -> HomeViewModelOutput
}
