//
//  UIView+Extension.swift
// Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import UIKit

extension UIView {
    

            
            
    func addBorder(color: UIColor? = UIColor.clear, width: CGFloat, radius: CGFloat) {
            layer.borderColor    = color!.cgColor
            layer.borderWidth    = width
            layer.cornerRadius   = radius
        }

}


