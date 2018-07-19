//
//  Example4View.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 19/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class Example4View: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    private func applyLayout() {
        //TODO COLOCAR UMA IMAGEM
        imageView.image = UIImage.fromColor(color: UIColor(red:0.91, green:0.12, blue:0.39, alpha:1.0))
        
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.light)
        titleLabel.text = "Three Invites"
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        descriptionLabel.textColor = UIColor.lightGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sit amet ante ut massa dignissim feugiat. Morbi eu faucibus diam. Nunc et nisl et tellus ultrices blandit. Proin pharetra hendrerit augue sed tempus. Aliquam vel nibh laoreet tortor euismod tempus. Integer et pharetra magna."
    }
    
    class func instantiateFromNib() -> Example4View {
        return Bundle.main.loadNibNamed("Example4View", owner: nil, options: nil)!.first as! Example4View
    }
}
