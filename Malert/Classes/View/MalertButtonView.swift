//
//  MalertButtonView.swift
//  Created by Vitor Mesquita on 01/11/16.
//

import UIKit

protocol MalertActionCallbackProtocol: class {
    func didTapOnAction()
}

public enum MalertButtonType {
    case normal
    case cancel
}

public class MalertButtonView: UIButton {
    
    private var actionBlock: (() -> ())?
    private var index = 0
    private var isHorizontalAxis = false
    private weak var callback: MalertActionCallbackProtocol?
    
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
    
    // MARK: Appearence
    
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
        callback?.didTapOnAction()
    }
}

extension MalertButtonView {
    
    /**
     * Initializer Malert button
     * - Parameters:
     *      - malertButton: Class to configure `MalertButtonView`
     **/
    
    func initializeMalertButton(malertButton: MalertAction, index: Int, hasMargin: Bool, isHorizontalAxis: Bool, callback: MalertActionCallbackProtocol?) {
        self.index = index
        self.isHorizontalAxis = isHorizontalAxis
        self.actionBlock = malertButton.actionBlock
        self.callback = callback
        
        if let height = malertButton.height {
            self.height = height
        }
    
        if let tintColor = malertButton.tintColor {
            self.tintColor = tintColor
        }
        
        if let separetorColor = malertButton.separetorColor {
            self.separetorColor = separetorColor
        }
        
        if let backgroundColor = malertButton.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        if !hasMargin {
            setUpViews()
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(malertButton.title, for: .normal)
        addTarget(self, action: #selector(MalertButtonView.buttonPressedAction(button:)), for: .touchUpInside)
    }
}

extension MalertButtonView {
    
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
