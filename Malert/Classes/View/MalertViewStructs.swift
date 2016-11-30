//
//  MalertViewStructs.swift
//  Pods
//
//  Created by Vitor Mesquita on 14/11/16.
//
//

import UIKit
import OAStackView

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
    var buttons: [MalertButtonStruct]
    var animationType: MalertAnimationType
    var configuration: MalertViewConfiguration?
    
    init(title: String?, customView: UIView, buttons: [MalertButtonStruct], animationType: MalertAnimationType, malertViewConfiguration: MalertViewConfiguration? = nil) {
        self.title = title
        self.customView = customView
        self.buttons = buttons
        self.configuration = malertViewConfiguration
        self.animationType = animationType
    }
}

/**
 * Struct to build MalertButtons
 * Parameters:
 *  - title: Title that will appear in button
 *  - type: MalertButton type which determines how the button will
 *  - actionBlock: Block which will called when click on button
 */
public struct MalertButtonStruct {
    var title: String
    var index = 0
    var isHorizontalAxis = false
    var hasMargin = false
    
    var backgroundColor: UIColor?
    var buttonConfiguration: MalertButtonConfiguration?
    var actionBlock: (() -> ())?
    //    var type: MalertButtonType
    
    public init(title: String, actionBlock: (() -> ())? = nil) {
        self.title = title
        self.actionBlock = actionBlock
    }
    
    public init(title: String, backgroundColor: UIColor, actionBlock: (() -> ())? = nil) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.actionBlock = actionBlock
    }
    
    public init(title: String, buttonConfiguration: MalertButtonConfiguration, actionBlock: (() -> ())? = nil) {
        self.title = title
        self.buttonConfiguration = buttonConfiguration
        self.actionBlock = actionBlock
    }
    
    public mutating func setButtonConfiguration(_ buttonConfiguration: MalertButtonConfiguration) {
        self.buttonConfiguration = buttonConfiguration
    }
}

/**
 * Struct to wrapper MalertAnimation
 * Parametes:
 *  - animationType: Is pre-determineted animations which malert will do when appear
 *  - malertView: current malertView to make animations with it
 *  - malertViewController: viewController container to build malerView
 */
struct MalertAnimationWrapper {
    var animationType: MalertAnimationType
    var malertView: MalertView
    var malertViewController: MalertViewController
    
    init(animationType: MalertAnimationType, malertView:MalertView, malertViewController: MalertViewController) {
        self.animationType = animationType
        self.malertView = malertView
        self.malertViewController = malertViewController
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

/**
 * Struct about MalertButton configuration
 */
public struct MalertButtonConfiguration {
    public var backgroundColor: UIColor = .clear
    public var tintColor: UIColor = .lightText
    public var separetorColor: UIColor = UIColor(white: 0.8, alpha: 1)
    public init() {}
}
