//
//  ViewController.swift
//  Malert
//
//  Created by Vitor Mesquita on 10/31/2016.
//  Copyright (c) 2016 Vitor Mesquita. All rights reserved.
//

import UIKit
import Malert

class ViewController: UIViewController {
    
    var btConfiguration = MalertButtonConfiguration()
    
    var dismissButton = MalertButtonStruct(title: "No, thanks") {
        MalertManager.shared.dismiss()
    }
    
    lazy var firstCustomView: FirstCustomView = {
        return FirstCustomView.instantiateFromNib()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
    @IBAction func buttonShowMalertWithImageAction(_ sender: AnyObject) {
        showFirstExample()
    }
    
    @IBAction func buttonShowMalertWithTitleAction(_ sender: AnyObject) {
        showSecondExample()
    }
    
    @IBAction func buttonShowThirdExampleAction(_ sender: AnyObject) {
        showThirdExample()
    }
}

//MARK: Build malert examples
extension ViewController {
    
    func showFirstExample() {
        firstCustomView.populate(title: "First Example", message: "This is first example to show for you how to use Malert :)")
        
        let showSecondMalertButton = MalertButtonStruct(title: "Show second Malert") { [weak self] in
            guard let strongSelf = self else { return }
            MalertManager.shared.dismiss(with: { (finished) in
                strongSelf.showSecondExample()
            })
        }
        
        MalertManager.shared.show(customView: firstCustomView, buttons: [showSecondMalertButton, dismissButton])
    }
    
    func showSecondExample() {
        let malertConfiguration = Helper.setUpSecondExampleCustomMalertViewConfig()
        btConfiguration.tintColor = malertConfiguration.textColor
        btConfiguration.separetorColor = .white
        
        let messageLabel = UILabel()
        messageLabel.textColor = malertConfiguration.textColor
        messageLabel.textAlignment = malertConfiguration.textAlign
        messageLabel.numberOfLines = 0
        messageLabel.text = "This is second example. Explaning how to use and customize your malert"
        
        let showThirdExempleButton = MalertButtonStruct(title: "Third example", buttonConfiguration: btConfiguration) { [weak self] in
            guard let strongSelf = self else { return }
            MalertManager.shared.dismiss(with: { (finished) in
                strongSelf.showThirdExample()
            })
        }
        
        var updatedDismissButton = dismissButton
        updatedDismissButton.setButtonConfiguration(btConfiguration)
        
        MalertManager.shared.show(title: "Hello!", customView: messageLabel, buttons: [showThirdExempleButton, updatedDismissButton], animationType: .modalRight, malertConfiguration: malertConfiguration)
    }
    
    func showThirdExample() {
        let malertConfig = Helper.setUpThirdExampleCustomMalertViewConfig()
        btConfiguration.tintColor = malertConfig.textColor
        btConfiguration.separetorColor = .clear
        
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Example textField"
        
        let thatIsAllFolksButton = MalertButtonStruct(title: "That's all folks", buttonConfiguration: btConfiguration) {
            MalertManager.shared.dismiss()
        }
        
        MalertManager.shared.show(title: "I Hope that it help you", customView: textField, buttons: [thatIsAllFolksButton], animationType: .modalLeft, malertConfiguration: malertConfig)
    }
}
