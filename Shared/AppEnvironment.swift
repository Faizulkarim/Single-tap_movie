//
//  AppEnvironment.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import Foundation
import UIKit
/// Bootstrap App Environment
struct AppEnvironment {
    let dependencyManager: DependencyManager
    let rootWindow: UIWindow?
}

extension AppEnvironment {
    
    static func bootstrap(rootWindow: UIWindow?) -> AppEnvironment {
        let dependencyManager = OTDependencyManager.defaultValue
        return AppEnvironment(dependencyManager: dependencyManager,
                              rootWindow: rootWindow)
    }
    
    func startApp(environment: OTEnvironment) {
        setupDependencyManager(environment: environment)
        dependencyManager.launchSequencer().launch()
    }
    
    private func setupDependencyManager(environment: OTEnvironment) {
        dependencyManager.configure(environment: environment,
                                    rootWindow: rootWindow)
        dependencyManager.startServices()
    }
}
