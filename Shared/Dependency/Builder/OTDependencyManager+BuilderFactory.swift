//
//  OTDependencyManager+BuilderFactory.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import Foundation

extension OTDependencyManager {
    func splashBuilder() -> SplashBuildable {
        return SplashBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    
    func homeBuilder() -> HomeBuildable {
        return HomeBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    
}
