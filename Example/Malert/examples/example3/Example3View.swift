//
//  Example3View.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 17/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class Example3View: UIView {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createLayer()
    }
    
    private func createLayer() {
        gradientLayer.frame = self.headerView.bounds
        let endColor = UIColor(red:0.40, green:0.12, blue:1.00, alpha:1.0)
        let middelColor = UIColor(red:0.10, green:0.46, blue:0.82, alpha:1.0)
        let startColor = UIColor(red:0.00, green:0.90, blue:1.00, alpha:1.0)
        gradientLayer.colors = [startColor.cgColor, middelColor.cgColor, endColor.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        headerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func applyLayout() {
        imageView.image = #imageLiteral(resourceName: "ic_ticket")
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.thin)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = "Congratulations,\nwelcome to cinema!"
        
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        messageLabel.textAlignment = .center
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce varius sodales tincidunt."
    }
    
    class func instantiateFromNib() -> Example3View {
        return Bundle.main.loadNibNamed("Example3View", owner: nil, options: nil)!.first as! Example3View
    }
}
