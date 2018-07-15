//
//  Helper.swift
//  Pods
//
//  Created by Vitor Mesquita on 04/09/17.
//
//

import UIKit

class Helper {
    
    static func buildButtonsBy(buttons: [MalertButton]?, hasMargin: Bool, isHorizontalAxis: Bool) -> [MalertButtonView]? {
        guard let buttons = buttons else { return nil }
        
        return buttons.enumerated().map { (index, button) -> MalertButtonView in
            let buttonView = MalertButtonView(type: .system)
            buttonView.initializeMalertButton(malertButton: button, index: index, hasMargin: hasMargin, isHorizontalAxis: isHorizontalAxis)
            return buttonView
        }
    }
    
}
