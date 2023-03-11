//
//  UIView+Extension.swift
// Single-tap-Movie
//
//  Created by Md Faizul karim on 11/3/23.
//

import UIKit

extension UIView {
    
    func addShadow(color: UIColor, opacity: Float, sizeX: CGFloat, sizeY: CGFloat, shadowRadius: CGFloat) {
            layer.shadowColor   = color.cgColor
            layer.shadowOpacity = opacity
            layer.shadowOffset  = CGSize(width: sizeX, height: sizeY)
            layer.shadowRadius  = shadowRadius
        }
            
            
    func addBorder(color: UIColor? = UIColor.clear, width: CGFloat, radius: CGFloat) {
            layer.borderColor    = color!.cgColor
            layer.borderWidth    = width
            layer.cornerRadius   = radius
        }

        func addBeizerCorners(corners:UIRectCorner, radius: CGFloat) {
            DispatchQueue.main.async {
                let path = UIBezierPath(roundedRect: self.bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii: CGSize(width: radius, height: radius))
                let maskLayer = CAShapeLayer()
                maskLayer.frame = self.bounds
                maskLayer.path = path.cgPath
                self.layer.mask = maskLayer
            }
        }
    func addBlurEffect(){
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.layer.opacity = 0.80
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
        
    }
    
    func removeBlurEffect() {
      let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
      blurredEffectViews.forEach{ blurView in
        blurView.removeFromSuperview()
      }
    }
    fileprivate typealias ReturnGestureAction = (() -> Void)?
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer1"
    }
    fileprivate var tapGestureRecognizerAction: ReturnGestureAction? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? ReturnGestureAction
            return tapGestureRecognizerActionInstance
        }
    }
    func handleTapToAction(action: (() -> Void)?) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureHanldeAction))
        self.tapGestureRecognizerAction = action
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }

    @objc func tapGestureHanldeAction() {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {

        }
    }
    
    
    func addGradient(colors: [UIColor] = [.blue, .white], locations: [NSNumber] = [0, 1], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 0, y: 1), type: CAGradientLayerType = .axial){
            let gradient = CAGradientLayer()
            gradient.frame.size = self.frame.size
            gradient.frame.origin = CGPoint(x: 0.0, y: 0.0)
        gradient.colors = colors.map{ $0.cgColor }
            
            gradient.locations = locations
            gradient.startPoint = startPoint
            gradient.endPoint = endPoint

            self.layer.insertSublayer(gradient, at: 0)
        

    }
    
    func constrainToEdges(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false

        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0
        )

        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0
        )

        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0
        )

        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0
        )

        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint,
        ])
    }
    
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addDashedBorder(color: UIColor? = UIColor.clear, width: CGFloat) {
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color?.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}


