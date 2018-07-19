//
//  Colors.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 15/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let primary = UIColor(red: 0.16, green: 0.71, blue: 0.96, alpha: 1.0)
    static let imageExample = UIColor(red:0.46, green:0.46, blue:0.46, alpha:1.0)
    static let formExample = UIColor(red:0.96, green:0.32, blue:0.12, alpha:1.0)
    static let customizableExample = UIColor(red:0.75, green:0.79, blue:0.20, alpha:1.0)
    static let expandableExample = UIColor(red:0.49, green:0.30, blue:1.00, alpha:1.0)
}

// MARK: - UIImage
extension UIImage {
    
    static func fromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }
}
