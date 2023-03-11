//
//  HomeViewController.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

// MARK: HomeViewController
final class HomeViewController: BaseHomeViewController {
    
    // MARK: Variables
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var router: HomeRouter?
    private let viewModel: HomeViewModelType

    // MARK: Interactions
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let movieListApiSubject = PassthroughSubject< Parameters, Never>()

    var displayModel = HomeDisplayModel()
    // MARK: Init Functions
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: HomeViewModelType,
         router: HomeRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(analyticsManager: analyticsManager, theme: theme)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind(to: viewModel)
        setupRouter()
        viewDidLoadSubject.send()
        
        let params: Parameters = ["api_key": "ss", "query": "marvel"]
        self.movieListApiSubject.send(params)
        
    }
    
}

// MARK: Private Default Methods
private extension HomeViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }

    /// Setup UI
    private func setupUI() {
        tableView.registerCell(HomeTableCell.self)
    }

    /// Bind viewmodel
    private func bind(to viewModel: HomeViewModelType) {
        /// Clear all observer
        disposeBag.cancel()
        let input = HomeViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(), movieListApiSubject: movieListApiSubject.eraseToAnyPublisher())
                
        let output = viewModel.transform(input: input)
        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }

    /// Render UI
    private func render(_ state: HomeViewState) {
        switch state {
        case .viewDidLoad:
            break
        case .loading(let shouldShow):
            shouldShow ? addLoadIndicator() : removeLoadIndicator()
        case .apiFailure(customError: let customError):
            print(customError)
        case .apiSuccess(response: let response):
            print(response)
            displayModel.movieData = response
            self.tableView.reloadData()
        }
    }
    
}

// MARK: Private Actions
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.nameId) as! HomeTableCell
        cell.theme = theme
        cell.indexPath = indexPath
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
