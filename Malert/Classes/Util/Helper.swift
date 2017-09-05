//
//  Helper.swift
//  Pods
//
//  Created by Vitor Mesquita on 04/09/17.
//
//

import UIKit

class Helper {
    
    static func buildButtonsBy(buttonsStruct: [MalertButtonStruct]?, hasMargin: Bool, isHorizontalAxis: Bool) -> [MalertButton]? {
        guard let buttonsStruct = buttonsStruct else { return nil }
        
        return buttonsStruct.enumerated().map { (index, buttonStruct) -> MalertButton in
            let button = MalertButton(type: .system)
            var updatedButtonStruct = buttonStruct
            updatedButtonStruct.index = index
            updatedButtonStruct.hasMargin = hasMargin
            updatedButtonStruct.isHorizontalAxis = isHorizontalAxis
            button.initializeMalertButton(malertButtonStruct: updatedButtonStruct)
            return button
        }
    }
    
}
