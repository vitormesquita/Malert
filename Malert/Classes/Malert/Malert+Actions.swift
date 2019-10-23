//
//  Malert+Actions.swift
//  Malert
//
//  Created by Vitor Mesquita on 16/07/2018.
//

import UIKit

extension Malert {
   
   @objc func tapOnView(_ sender: UITapGestureRecognizer) {
      if tapToDismiss && keyboardRect == .zero {
         let point = sender.location(in: self.view)
         
         let isPointInMalertView = malertView.frame.contains(point)
         if !isPointInMalertView {
            dismiss(animated: true, completion: self.completionBlock)
         }
      } else {
         self.view.endEditing(true)
      }
   }
}

extension Malert: MalertActionCallbackProtocol {
   
   func didTapOnAction() {
      if dismissOnActionTapped {
         dismiss(animated: true, completion: self.completionBlock)
      }
   }
}
