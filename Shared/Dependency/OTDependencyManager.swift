//
//  OTDependencyManager.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import Foundation
import UIKit

final class OTDependencyManager {
    static var defaultValue: OTDependencyManager { Self.default }
    
    private var environment: OTEnvironment = .production
    private var rootWindow: UIWindow?
    
    private var _launchSequencer: LaunchSequencer?
    private var _sharedAnalyticsManager: AnalyticsManager?
    private var _apiManager: OTAPIManager?
    private var _theme: Theme?
    private static let `default` = OTDependencyManager()
}

extension OTDependencyManager: DependencyManager {

    
    
    // MARK: - Instance functions
    
    func configure(environment: OTEnvironment,
                   rootWindow: UIWindow?) {
        self.environment = environment
        self.rootWindow = rootWindow
    }
    
    func startServices() {
                
        #if DEBUG || ALPHA || BETA
        //
        #endif
    }
    
    #if DEBUG || ALPHA || BETA
    
    ///  Re-configured dependency manager with the new environement.
    ///
    /// - Parameters:
    ///   - environment: Environment.
    
    func switchEnvironment(environment: OTEnvironment) {
        clear()
        self.environment = environment
        self.rootWindow?.subviews.forEach { $0.removeFromSuperview() }
        
        startServices()
        launchSequencer().relaunch()
    }
    
    #endif
    
    private func clear() {
        self._theme = nil
        self._launchSequencer = nil
    }
}

// MARK: Utility Factory Protocol Implementaion
extension OTDependencyManager {
    
    func apiManager() -> OTAPIManager {
        if _apiManager == nil {
            _apiManager = OTAPIManager() //Init with key manager to pass dependent key
        }
        return _apiManager ?? OTAPIManager()
    }
        
    func launchSequencer() -> LaunchSequencer {
        if _launchSequencer == nil {
            _launchSequencer = LaunchSequencer(rootWindow: rootWindow,
                                               dependencyManager: self)
        }
        return _launchSequencer!
    }
    
    func analyticsManager() -> AnalyticsManager {
        if _sharedAnalyticsManager == nil {
            _sharedAnalyticsManager = DefaultAnalyticsManager()
        }

        return _sharedAnalyticsManager!
    }
    
    func theme() -> Theme {
        if _theme == nil {
            let colorTheme: ColorTheme = OTColorTheme()
            let fontTheme: FontTheme = OTFontTheme()
            let imageTheme: ImageTheme = OTImageTheme()
            let layerTheme: LayerTheme = OTLayerTheme()
            
            _theme = DefaultTheme(colorTheme: colorTheme,
                                  fontTheme: fontTheme,
                                  imageTheme: imageTheme,
                                  layerTheme: layerTheme)
        }
        return _theme!
    }
    
}
