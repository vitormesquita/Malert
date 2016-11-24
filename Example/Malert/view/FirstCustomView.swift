//
//  FirstCustomView.swift
//  Malert
//
//  Created by Vitor Mesquita on 22/11/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class FirstCustomView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = UIColor(red:1.0, green:0.27, blue:0.27, alpha:1.0)
    }
    
    func populate(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
    
    class func instantiateFromNib() -> FirstCustomView{
        return Bundle.main.loadNibNamed("FirstCustomView", owner: nil, options: nil)!.first as! FirstCustomView
    }
}
