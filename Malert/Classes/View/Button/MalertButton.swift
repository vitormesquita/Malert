//
//  MalertButton.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/11/16.
//
//

import UIKit

public enum MalertButtonType {
    case normal
    case cancel
}

public class MalertButton: UIButton {
    
    private var actionBlock: (() -> ())?
    private var index = 0
    private var isHorizontalAxis = false
    
    // The separetor line on top button
    private lazy var separetor: UIView = {
        let separetorLine = UIView(frame: .zero)
        separetorLine.backgroundColor = UIColor(white: 0.8, alpha: 1)
        separetorLine.translatesAutoresizingMaskIntoConstraints = false
        return separetorLine
    }()
    
    // The separetor line on left button
    private lazy var leftSeparetor: UIView = {
        let leftSeparetorLine = UIView(frame: .zero)
        leftSeparetorLine.translatesAutoresizingMaskIntoConstraints = false
        leftSeparetorLine.backgroundColor = UIColor(white: 0.8, alpha: 1)
        return leftSeparetorLine
    }()
    
    //MARK: Appearance 
    
    // Button Height
    @objc public dynamic var height: CGFloat {
        get { return bounds.size.height }
        set { heightAnchor.constraint(equalToConstant: newValue).isActive = true }
    }
    
    // The separator color of this button
    @objc public dynamic var separetorColor: UIColor? {
        get { return separetor.backgroundColor }
        set {
            separetor.backgroundColor = newValue
            leftSeparetor.backgroundColor = newValue
        }
    }
    
    //MARK: Action
    @objc func buttonPressedAction(button: UIButton){
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
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(malertButtonStruct.title, for: .normal)
        addTarget(self, action: #selector(MalertButton.buttonPressedAction(button:)), for: .touchUpInside)
    }
}

extension MalertButton {
    
    private func setConfiguration(malertButtonConfiguration: MalertButtonConfiguration) {
        self.backgroundColor = malertButtonConfiguration.backgroundColor
        self.separetorColor = malertButtonConfiguration.separetorColor
        self.tintColor = malertButtonConfiguration.tintColor
    }
    
    private func setUpViews() {
        addSubview(separetor)
        addSubview(leftSeparetor)
        
        let separetorConstraints = [
            separetor.topAnchor.constraint(equalTo: self.topAnchor),
            separetor.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separetor.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separetor.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        NSLayoutConstraint.activate(separetorConstraints)
        
        if isHorizontalAxis && index != 0 {
            
            let leftSeparetorConstraints = [
                leftSeparetor.topAnchor.constraint(equalTo: self.topAnchor),
                leftSeparetor.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                leftSeparetor.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                leftSeparetor.widthAnchor.constraint(equalToConstant: 1)
            ]
            
            NSLayoutConstraint.activate(leftSeparetorConstraints)
        }
    }
}
