//
//  Extensions.swift
//  Pods
//
//  Created by Vitor Mesquita on 04/09/17.
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

extension UILabel {
   
   static func ilimitNumberOfLines() -> UILabel {
      let label = UILabel()
      label.numberOfLines = 0
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }
}

extension UIStackView {
   
   static func defaultStack(axis: NSLayoutConstraint.Axis) -> UIStackView {
      let stack = UIStackView()
      stack.distribution = .fillEqually
      stack.alignment = .fill
      stack.axis = axis
      stack.spacing = 0
      stack.translatesAutoresizingMaskIntoConstraints = false
      return stack
   }
}
