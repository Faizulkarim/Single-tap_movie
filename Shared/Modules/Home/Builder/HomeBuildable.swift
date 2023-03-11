//
//  HomeBuildable.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

/// Home builder protocol.
protocol HomeBuildable {

    /// Builds the Home view.
    ///
    /// - Returns: Home details view.
    func build() -> UIViewController

}
