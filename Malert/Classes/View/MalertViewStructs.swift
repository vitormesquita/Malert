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
    var buttons: [MalertButtonConfig]
    var animationType: MalertAnimationType
    var configuration: MalertViewConfiguration?
    
    init(title: String?, customView: UIView, buttons: [MalertButtonConfig], animationType: MalertAnimationType, malertViewConfiguration: MalertViewConfiguration? = nil) {
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
public struct MalertButtonConfig {
    var title: String
    var type: MalertButtonType
    var index = 0
    var isHorizontalAxis = false
    
    var backgroundColor: UIColor?
    var actionBlock: (() -> ())?
    
    public init(title: String, type: MalertButtonType, actionBlock: (() -> ())? = nil) {
        self.title = title
        self.type = type
        self.actionBlock = actionBlock
    }
    
    public init(title: String, type: MalertButtonType, backgroundColor: UIColor, actionBlock: (() -> ())? = nil) {
        self.title = title
        self.type = type
        self.backgroundColor = backgroundColor
        self.actionBlock = actionBlock
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
 *
 */
public struct MalertViewConfiguration {
    public var backgroundColor: UIColor = .white
    public var cornerRadius: CGFloat = 6
    public var textColor: UIColor = .black
    public var textAlign: NSTextAlignment = .left
    public var buttonDistribution: OAStackViewDistribution = .fillEqually
    public var buttonsAligment: OAStackViewAlignment = .fill
    public var buttonsAxis: UILayoutConstraintAxis = .vertical
    public var margin: CGFloat = 0
    public init() {}
}
