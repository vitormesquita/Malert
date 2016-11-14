//
//  UIViewExtensions.swift
//  Pods
//
//  Created by Vitor Mesquita on 10/11/16.
//
//

import UIKit

extension UIView {
    
    public func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
