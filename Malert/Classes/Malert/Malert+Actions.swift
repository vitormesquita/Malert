//
//  Malert+Actions.swift
//  Malert
//
//  Created by Vitor Mesquita on 16/07/2018.
//

import UIKit

extension Malert {
    
    @objc func tapOnView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        if tapToDismiss {
            let point = sender.location(in: self.view)
            
            let isPointInMalertView = malertView.frame.contains(point)
            if !isPointInMalertView {
                dismiss(animated: true) {
                    print("dismissed")
                }
            }
        }
    }
}

extension Malert: MalertActionCallbackProtocol {
    
    func didTapOnAction() {
        if dismissOnActionTapped {
            dismiss(animated: true) {
                print("dismissed")
            }
        }
    }
}
