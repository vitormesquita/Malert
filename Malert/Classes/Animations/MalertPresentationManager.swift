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

class MalertPresentationManager: NSObject, UIViewControllerTransitioningDelegate {
    
    var animationType: MalertAnimationType = .modalBottom
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MalertAnimatedTransitioning(animationType: self.animationType)
    }

}
