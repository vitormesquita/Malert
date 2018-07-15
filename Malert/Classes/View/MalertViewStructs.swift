//
//  MalertViewStructs.swift
//  Pods
//
//  Created by Vitor Mesquita on 14/11/16.
//
//

import UIKit

/**
 * Struct to build MalertView
 * Parameters:
 *  - title: Malert's title
 *  - customView: Custom view to appear is content of alert
 *  - buttons: Array of structs to build any buttons that you want
 *  - animationType: 
 *  - malertViewConfiguration: Struct which contains all configurations that you can custom, is optional will pass default values
 */
struct MalertViewStruct {
    var title: String?
    var customView: UIView
    var buttons: [MalertButton]
    var animationType: MalertAnimationType
    var configuration: MalertViewConfiguration?
    var tapToDismiss: Bool
    
    init(title: String?,
         customView: UIView,
         buttons: [MalertButton],
         animationType: MalertAnimationType,
         malertViewConfiguration: MalertViewConfiguration?,
         tapToDismiss: Bool) {
        
        self.title = title
        self.customView = customView
        self.buttons = buttons
        self.animationType = animationType
        self.configuration = malertViewConfiguration
        self.tapToDismiss = tapToDismiss
    }
}

/**
 * Class to build `MalertButtonView`
 * Parameters:
 *  - title: Title that will appear in button
 *  - type: MalertButton type which determines how the button will
 *  - actionBlock: Block which will called when click on button
 */
public class MalertButton {
    
    var title: String
    var actionBlock: (() -> ())?
    
    public var height: CGFloat = 44
    public var tintColor: UIColor = .lightText
    public var backgroundColor: UIColor = .clear
    public var separetorColor: UIColor = UIColor(white: 0.8, alpha: 1)
    
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

/**
 * Struct about MalertView configuration
 */
public struct MalertViewConfiguration {
    public var backgroundColor: UIColor = .white
    public var textColor: UIColor = .black
    public var textAlign: NSTextAlignment = .left
    public var buttonsAxis: UILayoutConstraintAxis = .vertical
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 14)
    public var cornerRadius: CGFloat = 6
    public var margin: CGFloat = 0
    public var buttonsMargin: CGFloat = 0
    public var buttonsSpace: CGFloat = 0
    public init() {}
}
