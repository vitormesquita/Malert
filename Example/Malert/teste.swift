//
//  teste.swift
//  Malert
//
//  Created by Vitor Mesquita on 01/11/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class teste: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func instantiateFromNib() -> teste{
        return Bundle.main.loadNibNamed("teste", owner: nil, options: nil)!.first as! teste
    }
}
