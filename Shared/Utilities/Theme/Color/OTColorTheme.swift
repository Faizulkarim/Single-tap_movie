//
//  OTColorTheme.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import UIKit

struct OTColorTheme: ColorTheme {
    var clearColor: UIColor {
        return .clear
    }
    var colorPrimaryWhite : UIColor? {
        return UIColor.init(named: "PrimaryWhite")
    }
    
    var colorPrimaryBlack : UIColor? {
        return UIColor.init(named: "PrimaryBlack")
    }
    
    
    
}
