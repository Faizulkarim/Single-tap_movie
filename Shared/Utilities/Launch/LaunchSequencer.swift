//
//  LaunchSequencer.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import Foundation

import UIKit
import CoreAudio

/// Describes events and their order for application launch.
final class LaunchSequencer {
    
    private let rootWindow: UIWindow?
    private let dependencyManager: DependencyManager
    
    // MARK: - Init/Deinit
    
    init(rootWindow: UIWindow?,
         dependencyManager: DependencyManager) {
        self.rootWindow = rootWindow
        self.dependencyManager = dependencyManager
    }
    
    // MARK: - Instance functions
    
    /// Runs sequence of steps that should occur at launch
    /// to ensure proper application state and appearance.
    func launch() {
        installRootView()
    }
    
    #if DEBUG || ALPHA || BETA

    func relaunch() {
        installRootView()
    }

    #endif
    
    private func installRootView() {
        
        let appView = self.dependencyManager.splashBuilder().build()
        appView.navigationController?.navigationBar.isHidden = true
        self.rootWindow?.rootViewController = appView
        self.rootWindow?.makeKeyAndVisible()
       
        setStatusBar(backgroundColor: dependencyManager.theme().colorTheme.clearColor)

    }
    
    func changeRootTo(navigationController: UINavigationController) {
        self.rootWindow?.rootViewController = navigationController
        self.rootWindow?.makeKeyAndVisible()
       setStatusBar(backgroundColor: dependencyManager.theme().colorTheme.clearColor)
    }
    

    

}
