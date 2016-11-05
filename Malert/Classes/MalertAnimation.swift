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

struct MalertAnimationWrapper {
    var animationType: MalertAnimationType
    var malertView: MalertView
    var malertViewController: MalertViewController
    var malertWindow: UIWindow
    
    init(animationType: MalertAnimationType, malertView:MalertView, malertViewController: MalertViewController, malertWindow: UIWindow) {
        self.animationType = animationType
        self.malertView = malertView
        self.malertViewController = malertViewController
        self.malertWindow = malertWindow
    }
}

class MalertAnimation {
    
    class func buildAnimation(with malertAnimation: MalertAnimationWrapper) {
        switch malertAnimation.animationType {
        case .modalBottom:
            malertAnimation.malertView.transform = CGAffineTransform.init(translationX: 0, y: malertAnimation.malertWindow.bounds.size.height)
            break
            
        case .modalLeft:
            malertAnimation.malertView.transform = CGAffineTransform.init(translationX: -malertAnimation.malertWindow.bounds.size.height, y: 0)
            break
            
        case .modalRight:
            malertAnimation.malertView.transform = CGAffineTransform.init(translationX: malertAnimation.malertWindow.bounds.size.height, y: 0)
            break
            
        case .fadeIn:
            malertAnimation.malertView.alpha = 0
            break
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            malertAnimation.malertView.alpha = 1
            malertAnimation.malertViewController.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
            malertAnimation.malertView.transform = .identity
            }, completion: nil)
    }
}
