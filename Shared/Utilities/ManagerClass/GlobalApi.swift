//
//  GlobalApi.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import UIKit
import SwiftMessages

fileprivate let hideInterval: TimeInterval = 0.6

func showToast(message: String?) {
    if let validMessage = message {
        let toastView: SDToastView = try! SwiftMessages.viewFromNib()
        toastView.configureContent(body: validMessage)
        toastView.backgroundView.backgroundColor = UIColor.lightGray
        toastView.backgroundView.layer.cornerRadius = 15
        toastView.backgroundView.layer.masksToBounds = true

        var customViewConfig = SwiftMessages.defaultConfig
        customViewConfig.presentationStyle = .bottom
        customViewConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        customViewConfig.duration = .seconds(seconds: hideInterval)
        customViewConfig.dimMode = .none
        customViewConfig.shouldAutorotate = true
        customViewConfig.interactiveHide = false
        customViewConfig.preferredStatusBarStyle = .default
        SwiftMessages.show(config: customViewConfig, view: toastView)
    }
}

func showSDConfirmationPopup(title: String = "Evaly",
                             message: String?,
                             cancelTitle: String = "Cancel",
                             cancelAction: ButtonActionHandler?,
                             okTitle: String = "Confirm",
                             okAction: ButtonActionHandler?,
                             theme: Theme) {
    if let validMessage = message {
        let confirmationView: SDConfirmationPopup = try! SwiftMessages.viewFromNib()
        confirmationView.configureContent(title: title, body: validMessage)
        confirmationView.backgroundView.layer.cornerRadius = 15
        confirmationView.backgroundView.layer.masksToBounds = true

        let cancelViewModel = OTDynamicButtonViewModel(img: nil,
                                                   title: cancelTitle,
                                                   titleFont: theme.fontTheme.regularMontserrat.font(15),
                                                       titleColor: theme.colorTheme.colorPrimaryWhite,
                                                   backgroundColor: theme.colorTheme.colorPrimaryBlack,
                                                   borderColor: theme.colorTheme.clearColor,
                                                   cornerRadius: 6, isHidden: false)
        confirmationView.cancelView.configureView(viewModel: cancelViewModel) { sender  in
            SwiftMessages.hide(animated: true)
            cancelAction?(sender)
        }


        let okViewModel = OTDynamicButtonViewModel(img: #imageLiteral(resourceName: "TickBlack").withRenderingMode(.alwaysOriginal),
                                                    title: okTitle,
                                                    titleFont: theme.fontTheme.regularMontserrat.font(15),
                                                    titleColor: theme.colorTheme.colorPrimaryWhite,
                                                    backgroundColor: theme.colorTheme.colorPrimaryBlack,
                                                    borderColor: theme.colorTheme.clearColor,
                                                    cornerRadius: 6, isHidden: false)
        confirmationView.submitView.configureView(viewModel: okViewModel) { sender in
            SwiftMessages.hide(animated: true)
            okAction?(sender)
        }


        var customViewConfig = SwiftMessages.defaultConfig
        customViewConfig.presentationStyle = .center
        customViewConfig.presentationContext = .automatic
        customViewConfig.duration = .forever
        customViewConfig.dimMode = .color(color: .black.withAlphaComponent(0.4), interactive: false)
        customViewConfig.shouldAutorotate = true
        customViewConfig.interactiveHide = false
        customViewConfig.preferredStatusBarStyle = .default
        SwiftMessages.show(config: customViewConfig, view: confirmationView)
    }
}

func getAppEnvironment() -> OTEnvironment {
    #if BETA || ALPHA
        return .staging
        //return .dev
    #elseif DEBUG
        //return .dev
        return .staging
        //return .beta
        //return .production
    #else
        return .production
    #endif
}

func setStatusBar(backgroundColor: UIColor?) {
    let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    let statusBar = UIView(frame: window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
    statusBar.backgroundColor = backgroundColor
    window?.addSubview(statusBar)
    window?.bringSubviewToFront(statusBar)
}

