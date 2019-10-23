//
//  MalertInteractiveTransition.swift
//  Pods
//
//  Created by Vitor Mesquita on 03/03/17.
//
//

import Foundation

class MalertInteractiveTransition: UIPercentDrivenInteractiveTransition {
   
   var hasStarted = false
   var shouldFinish = false
   
   weak var viewController: UIViewController? = nil
   
   @objc func handlePan(_ sender: UIPanGestureRecognizer) {
      
      guard let _ = viewController else { return }
      
      guard let progress = calculateProgress(sender: sender) else { return }
      
      switch sender.state {
      case .began:
         hasStarted = true
      case .changed:
         shouldFinish = progress > 0.4
         update(progress)
      case .cancelled:
         hasStarted = false
         cancel()
      case .ended:
         hasStarted = false
         completionSpeed = 0.55
         shouldFinish ? finish() : cancel()
      default:
         break
      }
   }
}

internal extension MalertInteractiveTransition {
   
   func calculateProgress(sender: UIPanGestureRecognizer) -> CGFloat? {
      guard let vc = viewController else { return nil }
      
      // http://www.thorntech.com/2016/02/ios-tutorial-close-modal-dragging/
      let translation = sender.translation(in: vc.view)
      let verticalMovement = translation.y / vc.view.bounds.height
      let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
      let downwardMovementPercent = fminf(downwardMovement, 1.0)
      let progress = CGFloat(downwardMovementPercent)
      
      return progress
   }
}
