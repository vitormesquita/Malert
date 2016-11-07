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

public struct MalertButtonConfig {
    var title: String
    var type: MalertButtonType
    var enable: Bool
    var actionBlock: (() -> ())?
    
    public init(title: String, type: MalertButtonType, enable: Bool, actionBlock: (() -> ())? = nil) {
        self.title = title
        self.type = type
        self.enable = enable
        self.actionBlock = actionBlock
    }
}

public class MalertButton: UIButton {
    
    fileprivate var actionBlock: (() -> ())?
    fileprivate var index = 0
    fileprivate var isHorizontalAxis = false
    
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
    
    public dynamic var separatorColor: UIColor? {
        get { return separetor.backgroundColor }
        set {
            separetor.backgroundColor = newValue
            leftSeparetor.backgroundColor = newValue
        }
    }
    
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

    // Button action
    
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
     *  - index: Button index in array of buttonsConfig. To make logics about separetor lines
     *  - isHorizontalAxis: Boolean to know when show left separetor line
     **/
    
    func initializeMalertButton(malertButtonConfig: MalertButtonConfig, index:Int, isHorizontalAxis:Bool) {
        self.index = index
        self.isHorizontalAxis = isHorizontalAxis
        self.actionBlock = malertButtonConfig.actionBlock
        
        setUpViews()
        setTitle(malertButtonConfig.title, for: .normal)
        addTarget(self, action: #selector(MalertButton.buttonPressedAction(button:)), for: .touchUpInside)
    }
}

extension MalertButton {
    
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


