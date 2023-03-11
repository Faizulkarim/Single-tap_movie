//
//  BaseNavigationViewController.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import Foundation
import UIKit

class BaseNavigationViewController: UINavigationController {}

extension BaseNavigationViewController {
    
    static func createObj(with rootVC: UIViewController) -> BaseNavigationViewController  {
        let baseStoryBoard = UIStoryboard(name: "BaseStoryboard", bundle: Bundle.main)
        let baseNavigationViewController = baseStoryBoard.instantiateViewController(withIdentifier: "BaseNavigationViewController") as! BaseNavigationViewController
        baseNavigationViewController.viewControllers = [rootVC]
        return baseNavigationViewController
    }
    
}

extension BaseNavigationViewController: BottomPopupManageable {
    func updateBottomPopup() -> BottomPopupVariables {
        if let popupManageable = self.viewControllers.first as? BottomPopupManageable {
            return popupManageable.updateBottomPopup()
        }
        return BottomPopupVariables(pageHeight: UIScreen.main.bounds.size.height-80, isPanGestureEnable: false)
    }

}

extension BaseNavigationViewController: CenterPopupManageable {
    
    func updateCenterPopup() -> CenterPopupVariables {
        if let popupManageable = self.viewControllers.first as? CenterPopupManageable {
            return popupManageable.updateCenterPopup()
        }
        let width: CGFloat = 400
        let height: CGFloat = 560
        let mainScreen = UIScreen.main.bounds
        let x = mainScreen.size.width/2 - width/2
        let y = mainScreen.size.height/2 - height/2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        return CenterPopupVariables(animationPopupFrame: frame)
    }
}

