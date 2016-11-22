//
//  MalertAnimation.swift
//  Pods
//
//  Created by Vitor Mesquita on 04/11/16.
//
//

import UIKit

public enum MalertAnimationType {
    case modalBottom
    case modalLeft
    case modalRight
    case fadeIn
}

class MalertAnimation {
    
    /**
     * Build animations to show malertView by MalertAnimationType
     * Parameters:
     *  - malertAnimation: Struct to wrapper MalertAnimationType, MalertView and MalertViewController
     */
    class func buildAnimation(with malertAnimation: MalertAnimationWrapper) {
        switch malertAnimation.animationType {
        case .modalBottom:
            malertAnimation.malertView.transform = CGAffineTransform.init(translationX: 0, y: malertAnimation.malertViewController.view.bounds.size.height)
            break
            
        case .modalLeft:
            malertAnimation.malertView.transform = CGAffineTransform.init(translationX: -malertAnimation.malertViewController.view.bounds.size.height, y: 0)
            break
            
        case .modalRight:
            malertAnimation.malertView.transform = CGAffineTransform.init(translationX: malertAnimation.malertViewController.view.bounds.size.height, y: 0)
            break
            
        case .fadeIn:
            malertAnimation.malertView.transform = .identity
            malertAnimation.malertView.alpha = 0
            break
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            malertAnimation.malertView.alpha = 1
            malertAnimation.malertViewController.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
            malertAnimation.malertView.transform = .identity
            }, completion: nil)
    }
    
    /**
     * Build simple animation to malertWindow alpha to 0
     * Parameters:
     *  - malertWindow: UIWindow that will be recive animation
     *  - completion: Block the will be called when the animation finished
     */
    class func buildSimpleDismissAnimation(with malertWindow: UIWindow, completion: @escaping ((_ finished: Bool) -> ())) {
        UIView.animate(withDuration: 0.25, animations: {
            malertWindow.alpha = 0
        }) { (finished) in
            completion(finished)
        }
    }
    
    /**
     TODO
     * Complex animation to dismiss malertView by MalertAnimationType
     * Parameters:
     *  - malertAnimation: Struct to wrapper MalertAnimationType, MalertView and MalertViewController
     class func buildDismissAnimation(with malertAnimation: MalertAnimationWrapper, completion: (() -> ())?) {
     switch malertAnimation.animationType {
     case .modalBottom:
     malertAnimation.malertView.transform = CGAffineTransform.init(translationX: malertAnimation.malertViewController.view.bounds.size.height, y: 0)
     break
     
     default:
     malertAnimation.malertView.transform = CGAffineTransform.init(translationX: malertAnimation.malertViewController.view.bounds.size.height, y: 0)
     break
     }
     
     UIView.animate(withDuration: 0.5, animations: {
     malertAnimation.malertView.alpha = 0
     malertAnimation.malertView.transform = .identity
     }) { (finished) in
     if let completion = completion {
     completion()
     }
     }
     }
     */
}
