//
//  BaseMalertViewController.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/11/16.
//
//

import UIKit

class BaseMalertViewController: UIViewController {
    
    private(set) var keyboardRect = CGRect.zero
    
    func listenKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(BaseMalertViewController.keyboardWillShow(sender:)), name: .UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseMalertViewController.keyboardWillHide(sender:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(sender: NSNotification){
        guard let userInfo = sender.userInfo else {
            return
        }
        
        if let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue{
            self.keyboardRect = keyboardRect
        }
    }
    
    func keyboardWillHide(sender: NSNotification){
        keyboardRect = CGRect.zero
    }
}
