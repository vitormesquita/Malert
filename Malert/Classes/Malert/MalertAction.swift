//
//  MalertAction.swift
//  Malert
//
//  Created by Vitor Mesquita on 16/07/2018.
//

import UIKit

/**
 * Class to build `MalertButtonView`
 * Parameters:
 *  - title: Title that will appear in button
 *  - type: MalertButton type which determines how the button will
 *  - actionBlock: Block which will called when click on button
 */
public class MalertAction {
    
    var title: String
    var actionBlock: (() -> ())?
    
    public var height: CGFloat?
    public var tintColor: UIColor?
    public var backgroundColor: UIColor?
    public var separetorColor: UIColor?
    
    public init(title: String, actionBlock: (() -> ())? = nil) {
        self.title = title
        self.actionBlock = actionBlock
    }
    
    public init(title: String, backgroundColor: UIColor, actionBlock: (() -> ())? = nil) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.actionBlock = actionBlock
    }
}
