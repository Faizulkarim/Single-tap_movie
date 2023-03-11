//
//  HomeDisplayModel.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation


protocol HomePassableModel {}
// MARK: HomeDisplayModel
struct HomeDisplayModel {
    var dataSource = [HomePassableModel]()
    var movieData : MovieListAPIResponseModel? {
        didSet {
            loadCellViewModel()
        }
    }
    
    mutating func loadCellViewModel(){
        dataSource.removeAll()
        self.dataSource.append(MoviewListCellViewModel(movieList: movieData?.results ?? []))
    }
    
}

struct MoviewListCellViewModel: HomePassableModel {
    var movieList : [Movie]
}
