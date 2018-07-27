//
//  Example8View.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 27/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class Example8View: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    private func applyLayout() {
        backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "ic_email")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.bold)
        titleLabel.text = "THANK YOU!"
        
        messageLabel.textAlignment = .center
        messageLabel.textColor = .white
        messageLabel.text = "We just sent you a confirmation email.\nCheck out your inbox."
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.numberOfLines = 0
    }
    
    class func instantiateFromNib() -> Example8View {
        return Bundle.main.loadNibNamed("Example8View", owner: nil, options: nil)!.first as! Example8View
    }
}
