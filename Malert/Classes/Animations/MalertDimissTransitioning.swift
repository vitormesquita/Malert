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
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? MalertViewController, let toVC = transitionContext.viewController(forKey: .to) else {return}
        
        if let malertView = fromVC.getMalertView() {
        
            let duration = transitionDuration(using: transitionContext)
            UIView.animate(withDuration: duration, delay: 0, options: [], animations: {
                fromVC.view.backgroundColor = .clear
                self.buildMalertAnimation(malertView: malertView, width: fromVC.view.bounds.size.width, height: fromVC.view.bounds.size.height)
                
            }, completion: { (finished) in
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
    
    
}
