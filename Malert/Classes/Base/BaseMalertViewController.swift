//
//  BaseMalertViewController.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/11/16.
//
//

import UIKit

public class BaseMalertViewController: UIViewController {
   
   private(set) var keyboardRect = CGRect.zero
   
   func listenKeyboard(){
      NotificationCenter.default.addObserver(self, selector: #selector(BaseMalertViewController.keyboardWillShow(sender:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(BaseMalertViewController.keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
   }
   
   @objc func keyboardWillShow(sender: NSNotification){
      guard let userInfo = sender.userInfo else {
         return
      }
      
      if let keyboardRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue{
         self.keyboardRect = keyboardRect
      }
   }
   
   @objc func keyboardWillHide(sender: NSNotification){
      keyboardRect = CGRect.zero
   }
}
