//
//  Example2View.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 17/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class Example2View: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.size.width/2
    }
    
    private func applyLayout() {
        backgroundColor = .clear
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 800))
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "Example 2"
        
        imageView.image = #imageLiteral(resourceName: "ic_Profile_PlaceHolder")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce varius sodales tincidunt."
    }
    
    class func instantiateFromNib() -> Example2View {
        return Bundle.main.loadNibNamed("Example2View", owner: nil, options: nil)!.first as! Example2View
    }
}
