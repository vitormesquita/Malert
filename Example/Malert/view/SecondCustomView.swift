//
//  SecondCustomView.swift
//  Malert
//
//  Created by Vitor Mesquita on 29/11/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class SecondCustomView: UIView {

    @IBOutlet weak var titleLabel: UILabel!

    func populate(title: String) {
        titleLabel.text = title
    }
    
    class func instantiateFromNib() -> SecondCustomView{
        return Bundle.main.loadNibNamed("SecondCustomView", owner: nil, options: nil)!.first as! SecondCustomView
    }
}
