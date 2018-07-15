//
//  ExampleTableViewCell.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 15/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ExampleTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    private func applyLayout() {
        titleLabel.font = UIFont.systemFont(ofSize: 26)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
        containerView.layer.cornerRadius = 8
    }
    
    func populateWith(type: ExampleType) {
        containerView.backgroundColor = type.color
        
        switch type {
        case .withImage:
            titleLabel.text = "Images"
            descriptionLabel.text = "Creating malerts with images"
            
        case .textField:
            titleLabel.text = "Form"
            descriptionLabel.text = "Rendering forms on malert"
            
        case .customizable:
            titleLabel.text = "Simple but customizable"
            descriptionLabel.text = "Creating simples malerts but always customizable"
            
        case .expandable:
            titleLabel.text = "Dynamic"
            descriptionLabel.text = "Creating dynamics malerts"
        }
    }
}
