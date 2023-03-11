//
//  Theme.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import Foundation
protocol Theme {
    /// Color theme object.
    var colorTheme: ColorTheme { get set }
    
    /// Font theme object.
    var fontTheme: FontTheme { get set }
    
    /// Image theme object.
    var imageTheme: ImageTheme { get set }
    
    /// Layer theme object.
    var layerTheme: LayerTheme { get set }
}
