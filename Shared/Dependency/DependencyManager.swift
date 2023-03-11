//
//  DependencyManager.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import Foundation
import UIKit

protocol DependencyManager: BuilderFactory, UtilityFactory {
    
    ///  Configured dependency manager for usage.
    /// - warning: Should be called before attempting to start or access dependencies.
    ///
    /// - Parameters:
    ///   - environment: OTEnvironment.
    ///   - rootWindow: Root window of application.
    func configure(environment: OTEnvironment,
                   rootWindow: UIWindow?)
    
    /// Starts dependencies that need to be activated at launch.
    func startServices()
    
    #if DEBUG || ALPHA || BETA
    
    ///  Re-configured dependency manager with the new environement.
    ///
    /// - Parameters:
    ///   - environment: Environment.
    func switchEnvironment(environment: OTEnvironment)
    
    #endif
    
}
