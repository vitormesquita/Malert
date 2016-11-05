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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionButton(_ sender: AnyObject) {
        let malertButtonConfig = MalertButtonConfig(title: "teste", type: .normal, enable: true) { 
            MalertManager.sharedInstance.dismiss()
        }
        
        let malertButtonConfig2 = MalertButtonConfig(title: "teste2 ", type: .normal, enable: true) {
            MalertManager.sharedInstance.dismiss()
        }
        
        let malertButtonConfig3 = MalertButtonConfig(title: "teste3 ", type: .normal, enable: true) {
            MalertManager.sharedInstance.dismiss()
            MalertManager.sharedInstance.show(customView: teste.instantiateFromNib(), buttons: [malertButtonConfig, malertButtonConfig2], animationType: .modalLeft)
        }
        
        MalertManager.sharedInstance.show(title: "titulo", customView: teste.instantiateFromNib(), buttons: [malertButtonConfig, malertButtonConfig2, malertButtonConfig3], animationType: .modalLeft)
    }
}

