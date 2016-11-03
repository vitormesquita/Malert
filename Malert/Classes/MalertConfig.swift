//
//  MalertConfig.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/11/16.
//
//

import UIKit
import OAStackView

public class MalertStyle {
    
    //MARK: view
    
    var backgroundColor: UIColor = .white
    var cornerRadius: CGFloat = 6
    var margin: CGFloat = 16
    var textColor: UIColor = .black
    
    //MARK: stack
    
    var buttonsMargin: CGFloat = 0
    var buttonsSpace: CGFloat = 0
    var buttonsDistribution: OAStackViewDistribution = .fillEqually
    var buttonsAligment: OAStackViewAlignment = .fill
    var buttonsAxis: UILayoutConstraintAxis = .vertical
    
    
    //MARK: button
    
    var malertButtonStyle: MalertButtonStyle = MalertButtonStyle()
}

public class MalertButtonStyle {
    
    var backgroundColor: UIColor = .clear
    var tintColor: UIColor = .lightGray
    var separetorColor: UIColor = UIColor(white: 0.8, alpha: 1)
    var separetorWidth: CGFloat = 0.5
    var buttonHeight: CGFloat = 33
}

extension UIView {
    
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    func round(corners: UIRectCorner, radius: CGFloat)  -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}
