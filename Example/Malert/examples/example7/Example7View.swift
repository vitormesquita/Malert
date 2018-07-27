//
//  Example7View.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 26/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class Example7View: UIView {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    private func applyLayout() {
        emailTextField.placeholder = "EMAIL"
        passwordTextField.placeholder = "PASSWORD"
        
        forgotPasswordButton.setTitle("FORGOT YOUR PASSWORD", for: .normal)
        forgotPasswordButton.tintColor = .lightGray
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    class func instantiateFromNib() -> Example7View {
        return Bundle.main.loadNibNamed("Example7View", owner: nil, options: nil)!.first as! Example7View
    }
}
