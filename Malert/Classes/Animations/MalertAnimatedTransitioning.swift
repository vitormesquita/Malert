//
//  MalertAnimatedTransitioning.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/03/17.
//
//

import UIKit

class MalertAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame = UIScreen.main.bounds
    var animationType: MalertAnimationType
    
    init(animationType: MalertAnimationType) {
        self.animationType = animationType
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) as? MalertViewController else {return}
        
        toVC.view.frame = originFrame
        transitionContext.containerView.addSubview(toVC.view)
        
        if let malertView = toVC.getMalertView() {
            switch animationType {
            case .modalBottom:
                malertView.transform = CGAffineTransform.init(translationX: 0, y: toVC.view.bounds.size.height)
                break
                
            case .modalLeft:
                malertView.transform = CGAffineTransform.init(translationX: -toVC.view.bounds.size.height, y: 0)
                break
                
            case .modalRight:
                malertView.transform = CGAffineTransform.init(translationX: toVC.view.bounds.size.height, y: 0)
                break
                
            case .fadeIn:
                malertView.transform = .identity
                malertView.alpha = 0
                break
            }
            
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
