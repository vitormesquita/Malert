//
//  FiveCustomView.swift
//  Malert
//
//  Created by Vitor Mesquita on 04/09/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class FiveCustomView: UIView {

    @IBOutlet weak var collapisingView: UIView!
    @IBOutlet weak var collapsingHeightLayoutConstraint: NSLayoutConstraint!
   
    var collapsing = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collapisingView.backgroundColor = .red
    }

    @IBAction func tappedOnButton(_ sender: Any) {
        collapsing = !collapsing
        
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.collapsingHeightLayoutConstraint.constant = strongSelf.collapsing ? 0 : 100
            
            strongSelf.setNeedsUpdateConstraints()
//            strongSelf.updateConstraintsIfNeeded()
//            strongSelf.setNeedsLayout()
            strongSelf.layoutIfNeeded()
        }
    }
    
    class func instantiateFromNib() -> FiveCustomView{
        return Bundle.main.loadNibNamed("FiveCustomView", owner: nil, options: nil)!.first as! FiveCustomView
    }
}
