//
//  AppDelegate.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    // MARK: - Properties

    /// The app main window.
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    weak var viewController: UIViewController?
    /// The app dependency manager.
    private(set) var dependencyManager: DependencyManager!
    
    // MARK: Private properties
    
    // Flag for whether app was launched cold or from background.
    private var activatedFromBackground: Bool = false
    
    
    // MARK: UIApplicationDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        activatedFromBackground = false
        window!.overrideUserInterfaceStyle = .light
        let environment: AppEnvironment = AppEnvironment.bootstrap(rootWindow: window)
        dependencyManager = environment.dependencyManager
        if environmentForLaunch() == .dev {
            environment.startApp(environment: environmentForLaunch())
        } else {
            environment.startApp(environment: environmentForLaunch())
        }
        return true
    }



    
    // MARK: - Private Functions
    private func environmentForLaunch() -> OTEnvironment {
        #if BETA || ALPHA
        return .staging
        #elseif DEBUG
        return .dev
        #else
        return .production
        #endif
    }


}

