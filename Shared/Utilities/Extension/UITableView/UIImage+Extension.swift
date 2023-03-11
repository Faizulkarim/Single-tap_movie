//
//  UIImage+Extension.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 12/3/23.
//

import UIKit

import SDWebImage

extension UIImageView {
    
    func loadImage(baseUrl: String?, fileName: String?, placeHolderImage: UIImage? = UIImage(named: "placeholder-movieimage")) {
        guard let validBaseUrl = baseUrl else {
            self.image = placeHolderImage
            return
            
        }
        guard let validFileName = fileName else {
            self.image = placeHolderImage
            return
            
        }
        let completeImageUrl = validBaseUrl + validFileName
        self.sd_setImage(with: URL(string: completeImageUrl), placeholderImage: nil,options: [.highPriority]) { [weak self] downloadImage, error, _, _ in
            if let validImage = downloadImage {
                self?.image = validImage
            }else{
                self?.image = placeHolderImage
            }
        }
    }
    


    
}
