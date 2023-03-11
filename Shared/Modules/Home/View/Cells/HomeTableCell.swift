//
//  HomeTableCell.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeTableCellDelegate: AnyObject {}

class HomeTableCell: BaseTableViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var posterImage : UIImageView!
    @IBOutlet weak var movieTitle : UILabel!
    @IBOutlet weak var movieDescription : UILabel!
    weak var delegate: HomeTableCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(baseUrl : String,posterImage: String?, movieTitle: String?, movieDescription: String?) {
        self.posterImage.loadImage(baseUrl: baseUrl, fileName: posterImage)
        self.movieTitle.text = movieTitle
        self.movieDescription.text = movieDescription
    }
}


