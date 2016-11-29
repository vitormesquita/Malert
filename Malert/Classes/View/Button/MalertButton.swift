//
//  MalertButton.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/11/16.
//
//

import UIKit
import Cartography

public enum MalertButtonType {
    case normal
    case cancel
}

public class MalertButton: UIButton {
    
    fileprivate var actionBlock: (() -> ())?
    fileprivate var index = 0
    fileprivate var isHorizontalAxis = false
    
    // The separetor line on top button
    fileprivate lazy var separetor: UIView = {
        let separetorLine = UIView(frame: .zero)
        separetorLine.backgroundColor = UIColor(white: 0.8, alpha: 1)
        separetorLine.translatesAutoresizingMaskIntoConstraints = false
        return separetorLine
    }()
    
    // The separetor line on left button
    fileprivate lazy var leftSeparetor: UIView = {
        let leftSeparetorLine = UIView(frame: .zero)
        leftSeparetorLine.translatesAutoresizingMaskIntoConstraints = false
        leftSeparetorLine.backgroundColor = UIColor(white: 0.8, alpha: 1)
        return leftSeparetorLine
    }()
    
    //MARK: Appearance 
    
    // Button Height
    public dynamic var height: CGFloat {
        get { return bounds.size.height }
        set {
            constrain(self) { button in
                button.height >= newValue
            }
        }
    }
    
    // The separator color of this button
    public dynamic var separetorColor: UIColor? {
        get { return separetor.backgroundColor }
        set {
            separetor.backgroundColor = newValue
            leftSeparetor.backgroundColor = newValue
        }
    }
    
    //MARK: Action
    func buttonPressedAction(button: UIButton){
        if let actionBlock = actionBlock {
            actionBlock()
        }
    }
}

extension MalertButton {
    
    /**
     * Initializer Malert button
     * Parameters:
     *  - malertButtonConfig: Struct about simple configuraiton, like title and action block
     **/
    
    func initializeMalertButton(malertButtonStruct: MalertButtonStruct) {
        self.index = malertButtonStruct.index
        self.isHorizontalAxis = malertButtonStruct.isHorizontalAxis
        self.actionBlock = malertButtonStruct.actionBlock
        self.backgroundColor = malertButtonStruct.backgroundColor
        
        if let buttonConfiguration = malertButtonStruct.buttonConfiguration {
            setConfiguration(malertButtonConfiguration: buttonConfiguration)
        }
        
        if !malertButtonStruct.hasMargin {
            setUpViews()
        }
        
        setTitle(malertButtonStruct.title, for: .normal)
        addTarget(self, action: #selector(MalertButton.buttonPressedAction(button:)), for: .touchUpInside)
    }
}

extension MalertButton {
    
    fileprivate func setConfiguration(malertButtonConfiguration: MalertButtonConfiguration) {
        self.backgroundColor = malertButtonConfiguration.backgroundColor
        self.separetorColor = malertButtonConfiguration.separetorColor
        self.tintColor = malertButtonConfiguration.tintColor
    }
    
    fileprivate func setUpViews() {
        addSubview(separetor)
        addSubview(leftSeparetor)
        
        constrain(separetor, self) { (separetor, button) in
            separetor.top == button.top
            separetor.left == button.left
            separetor.right == button.right
            separetor.height == 1
        }
        
        if isHorizontalAxis && index != 0 {
            constrain(leftSeparetor, self, block: { (leftSeparetor, button) in
                leftSeparetor.top == button.top
                leftSeparetor.bottom == button.bottom
                leftSeparetor.left == button.left
                leftSeparetor.width == 1
            })
        }
    }
}
