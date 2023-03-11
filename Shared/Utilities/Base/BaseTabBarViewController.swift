//
//  BaseTabBarViewController.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import UIKit
class BaseTabBarViewController: UITabBarController {
    
    let dependencyManager = OTDependencyManager.defaultValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureTabBarControllers()
//        configureTabBarTheme()
    }
//
//    func configureTabBarControllers() {
//        let tabHome = dependencyManager.homeBuilder().build()
//        let tabHomeItem = UITabBarItem(title: "Home",
//                                      image: dependencyManager.theme().imageTheme.tabbar_home,
//                                      selectedImage: dependencyManager.theme().imageTheme.tabbar_home)
//        tabHome.tabBarItem = tabHomeItem
//
//        let tabShop = dependencyManager.catelogBuilder().build()
//        let tabShopItem = UITabBarItem(title: "Shop",
//                                      image: dependencyManager.theme().imageTheme.tabbar_shop,
//                                      selectedImage: dependencyManager.theme().imageTheme.tabbar_shop)
//        tabShop.tabBarItem = tabShopItem
//
//        let homeTryOn = dependencyManager.htoBuilder().build()
//        let homeTryOnItem = UITabBarItem(title: "Home try on",
//                                         image: dependencyManager.theme().imageTheme.tabbar_home_try_on,
//                                         selectedImage: dependencyManager.theme().imageTheme.tabbar_home_try_on)
//
//        homeTryOn.tabBarItem = homeTryOnItem
//
//
//        let tabCart = dependencyManager.cartBuilder().build()
//        let tabCartItem = UITabBarItem(title: "Cart",
//                                      image: dependencyManager.theme().imageTheme.tabbar_cart,
//                                      selectedImage: dependencyManager.theme().imageTheme.tabbar_cart)
//        tabCart.tabBarItem = tabCartItem
//
//        let tabProfile = dependencyManager.profileBuilder().build()
//        let tabProfileItem = UITabBarItem(title: "Profile",
//                                      image: dependencyManager.theme().imageTheme.tabbar_profile,
//                                      selectedImage: dependencyManager.theme().imageTheme.tabbar_profile)
//        tabProfile.tabBarItem = tabProfileItem
//        self.viewControllers = [tabHome,tabShop,homeTryOn, tabCart,tabProfile]
//    }
//
//    func configureTabBarTheme() {
//        tabBar.tintColor = dependencyManager.theme().colorTheme.colorSupportDarkBlue
//        tabBar.backgroundColor = dependencyManager.theme().colorTheme.colorPrimaryWhite
//    }
    
    func activateTab(index:Int) {
        if let vcs = self.viewControllers {
            self.selectedViewController =  vcs[index]
        }
    }
    
}

extension BaseTabBarViewController {
    
    static func createObj() -> BaseTabBarViewController  {
        let baseStoryBoard = UIStoryboard(name: "BaseStoryboard", bundle: Bundle.main)
        let baseTabBarViewController = baseStoryBoard.instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
        return baseTabBarViewController
    }
    
}
