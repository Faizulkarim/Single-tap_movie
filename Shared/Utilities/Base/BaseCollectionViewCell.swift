//
//  BaseCollectionViewCell.swift
//  Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import Foundation
import UIKit

// MARK: BaseCollectionViewCell
class BaseCollectionViewCell: UICollectionViewCell {

    /// Setup constraints status
    var didSetupConstraints: Bool = false
    
    /// Setup indexPath
    var indexPath: IndexPath?

    /// Analytics manager.
    var analyticsManager: AnalyticsManager?

    /// Theme.
    var theme: Theme?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isHighlighted: Bool {
      didSet {
        UIView.animate(withDuration: 0.5) {
          let scale: CGFloat = 0.9
          self.transform = self.isHighlighted ? CGAffineTransform(scaleX: scale, y: scale) : .identity
        }
      }
    }
}
