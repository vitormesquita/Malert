//
//  Example5View.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 19/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class Example5View: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    private func applyLayout() {
        //TODO PUT AN IMAGE
        containerView.backgroundColor = UIColor(red:1.00, green:0.44, blue:0.26, alpha:1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.text = "Oops..."
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sit amet ante ut massa dignissim feugiat. Morbi eu faucibus diam. Nunc et nisl et tellus ultrices blandit. Proin pharetra hendrerit augue sed tempus."
    }

    class func instantiateFromNib() -> Example5View {
        return Bundle.main.loadNibNamed("Example5View", owner: nil, options: nil)!.first as! Example5View
    }
}
