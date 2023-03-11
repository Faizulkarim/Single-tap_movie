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
    @IBOutlet weak var HomeSearchBar : UISearchBar!
    
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
        HomeSearchBar.delegate = self

        self.movieList(name: "marvel")
        
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
    private func movieList(name: String){
        let params: Parameters = ["api_key": "6c5d81c11842804290245b441aa39b0c", "query": name]
        self.movieListApiSubject.send(params)
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
        return displayModel.movieData?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let displayModel = displayModel.dataSource[0] as? MoviewListCellViewModel{
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.nameId) as! HomeTableCell
            cell.theme = theme
            cell.indexPath = indexPath
            let posterPath = displayModel.movieLists[indexPath.row].posterPath
            let posterImageUrl = "\(displayModel.posterBaseUrl ?? "")" + "\(posterPath ?? "")"
            let title = displayModel.movieLists[indexPath.row].title ?? ""
            let descripton = displayModel.movieLists[indexPath.row].overview ?? ""
            cell.configureCell(baseUrl: displayModel.posterBaseUrl ?? "",posterImage: posterPath, movieTitle: title, movieDescription: descripton)
            return cell
        }
        
     return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension HomeViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // This method is called when the user taps the search button on the keyboard.
        // Perform your search logic here.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // This method is called when the user changes the search text.
        // You can use this method to perform real-time search as the user types.
        if searchText.count > 2 {
            self.movieList(name: searchText)
        }else if searchText.count == 0 {
            self.movieList(name: "Marvel")
        }
      
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // This method is called when the user taps the cancel button on the search bar.
        // Clear your search results and dismiss the keyboard here.
    }
}

