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
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) as? MalertViewController else {return}
        
        toVC.view.frame = originFrame
        transitionContext.containerView.addSubview(toVC.view)
        
        if let malertView = toVC.getMalertView() {
            buildMalertAnimation(malertView: malertView, width: toVC.view.bounds.size.width, height: toVC.view.bounds.size.height)
            let duration = transitionDuration(using: transitionContext)
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                malertView.alpha = 1
                malertView.transform = .identity
                
            }, completion: { (finished) in
                transitionContext.completeTransition(finished)
            })
        }
    }
}
