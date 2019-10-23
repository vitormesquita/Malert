//
//  MalertAnimatedTransitioning.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/03/17.
//
//

import UIKit

class MalertPresentTransitioning: BaseTransitioning, UIViewControllerAnimatedTransitioning {
   
   var originFrame = UIScreen.main.bounds
   
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      return duration
   }
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      guard let toVC = transitionContext.viewController(forKey: .to) as? Malert else {return}
      
      toVC.view.frame = originFrame
      transitionContext.containerView.addSubview(toVC.view)
      
      let malertView = toVC.malertView
      buildMalertAnimation(malertView: malertView, width: toVC.view.bounds.size.width, height: toVC.view.bounds.size.height)
      let duration = transitionDuration(using: transitionContext)
      
      UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
         malertView.alpha = 1
         malertView.transform = .identity
         toVC.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
         
      }, completion: { (finished) in
         transitionContext.completeTransition(finished)
      })
   }
}
