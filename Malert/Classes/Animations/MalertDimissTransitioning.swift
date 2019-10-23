//
//  MalertDimissedTransitioning.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/03/17.
//
//

import UIKit

class MalertDimissTransitioning: BaseTransitioning, UIViewControllerAnimatedTransitioning {
   
   public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      return duration
   }
   
   public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      guard let fromVC = transitionContext.viewController(forKey: .from) as? Malert else {return}
      
      let malertView = fromVC.malertView 
      let duration = transitionDuration(using: transitionContext)
      
      UIView.animate(withDuration: duration, animations: {
         self.buildMalertAnimation(malertView: malertView, width: fromVC.view.bounds.size.width, height: fromVC.view.bounds.size.height)
         fromVC.view.backgroundColor = .clear
      }) { (finished) in
         transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      }
   }
}
