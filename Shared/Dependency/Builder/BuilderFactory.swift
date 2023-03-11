//
//  BuilderFactory.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import Foundation


protocol BuilderFactory {
    
    func splashBuilder() -> SplashBuildable
    func homeBuilder() -> HomeBuildable
    
}
