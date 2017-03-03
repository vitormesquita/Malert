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
    
    var dismissButton = MalertButtonStruct(title: "No, thanks") {
        Malert.shared.dismiss()
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
    
    @IBAction func buttonShowFourthExampleAction(_ sender: AnyObject) {
        showFourthExample()
    }
}

//MARK: Build malert examples
extension ViewController {
    
    func showFirstExample() {
        firstCustomView.populate(title: "First Example", message: "This is first example to show for you how to use Malert :)")
        
        let showSecondMalertButton = MalertButtonStruct(title: "Show second Malert") { [weak self] in
            guard let strongSelf = self else { return }
            Malert.shared.dismiss(with: { (finished) in
                strongSelf.showSecondExample()
            })
        }
        
        Malert.shared.show(viewController: self, customView: firstCustomView, buttons: [showSecondMalertButton, dismissButton])
    }
    
    func showSecondExample() {
        let malertConfiguration = Helper.setUpSecondExampleCustomMalertViewConfig()
        var btConfiguration = MalertButtonConfiguration()
        btConfiguration.tintColor = malertConfiguration.textColor
        btConfiguration.separetorColor = .white
        
        let showThirdExempleButton = MalertButtonStruct(title: "Third example", buttonConfiguration: btConfiguration) { [weak self] in
            guard let strongSelf = self else { return }
            Malert.shared.dismiss(with: { (finished) in
                strongSelf.showThirdExample()
            })
        }
        
        var updatedDismissButton = dismissButton
        updatedDismissButton.setButtonConfiguration(btConfiguration)
        
        Malert.shared.show(viewController: self, title: "Hello!", message: "This is second example. Explaning how to use and customize your malert", buttons: [showThirdExempleButton, updatedDismissButton], animationType: .modalRight, malertConfiguration: malertConfiguration)
    }
    
    func showThirdExample() {
        let malertConfig = Helper.setUpThirdExampleCustomMalertViewConfig()
        var btConfiguration = MalertButtonConfiguration()
        btConfiguration.tintColor = malertConfig.textColor
        btConfiguration.separetorColor = .clear
        
        var updatedDismissButton = dismissButton
        updatedDismissButton.setButtonConfiguration(btConfiguration)
        
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Example textField"
        
        let thatIsAllFolksButton = MalertButtonStruct(title: "Fourth example", buttonConfiguration: btConfiguration) {
            Malert.shared.dismiss(with: {[weak self] (_) in
                guard let strongSelf = self else { return }
                strongSelf.showFourthExample()
            })
        }
        
        Malert.shared.show(viewController: self, title: "I Hope that it help you", customView: textField, buttons: [thatIsAllFolksButton, updatedDismissButton], animationType: .modalLeft, malertConfiguration: malertConfig, tapToDismiss: false)
    }
    
    func showFourthExample() {
        let malertConfig = Helper.setUpFouthExampleCustomMalertViewConfig()
        
        var fourthButtonConfig = MalertButtonConfiguration()
        fourthButtonConfig.backgroundColor = UIColor(red:1.0, green:0.25, blue:0.25, alpha:1.0)
        fourthButtonConfig.tintColor = .white
        
        let customView = SecondCustomView.instantiateFromNib()
        customView.populate(title: "FourthExample")
        
        let dismissButton = MalertButtonStruct(title: "Well come to Malert", buttonConfiguration: fourthButtonConfig) {
            Malert.shared.dismiss()
        }
    
        Malert.shared.show(viewController: self, customView: customView, buttons: [dismissButton], animationType: .fadeIn, malertConfiguration: malertConfig)
    }
}
