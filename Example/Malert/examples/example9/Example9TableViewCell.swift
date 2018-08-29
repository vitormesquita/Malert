//
//  Example9TableViewCell.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 29/08/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class Example9TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
