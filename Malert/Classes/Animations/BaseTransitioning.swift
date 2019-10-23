//
//  BaseTransitioning.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/03/17.
//
//

import UIKit

class BaseTransitioning: NSObject {
   
   var animationType: MalertAnimationType
   var duration: TimeInterval
   
   init(animationType: MalertAnimationType, duration: TimeInterval) {
      self.animationType = animationType
      self.duration = duration
      super.init()
   }
   
   func buildMalertAnimation(malertView: UIView, width: CGFloat, height: CGFloat) {
      switch animationType {
      case .modalBottom:
         malertView.transform = CGAffineTransform.init(translationX: 0, y: height)
         break
         
      case .modalLeft:
         malertView.transform = CGAffineTransform.init(translationX: -width, y: 0)
         break
         
      case .modalRight:
         malertView.transform = CGAffineTransform.init(translationX: width, y: 0)
         break
         
      case .fadeIn:
         malertView.alpha = 0
         break
      }
   }
}
