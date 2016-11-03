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

class MalertButton: UIButton {
    
    private var actionBlock: (() -> ())?
    private var style: MalertStyle?
    private var index = 0
    private var count = 0
    
    private var cornerRadius: CGFloat = 0
    private var corners: UIRectCorner = .allCorners
    
    func initializeMalertButton(malertButtonConfig: MalertButtonConfig, malertStyle: MalertStyle, index:Int, buttonsCount:Int) {
        self.actionBlock = malertButtonConfig.actionBlock
        self.style = malertStyle
        self.index = index
        self.count = buttonsCount
        
        constrain(self) { button in
            button.height >= malertStyle.malertButtonStyle.buttonHeight
        }
        
        configLayout()
        self.setTitle(malertButtonConfig.title, for: .normal)
        self.addTarget(self, action: #selector(MalertButton.buttonPressedAction(button:)), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.applyLayout()
        }
    }
    
    private func configLayout() {
        if let style = style {
            if style.buttonsAxis == .vertical {
                if index == count-1 {
                    cornerRadius = style.cornerRadius
                    corners = [.bottomLeft, .bottomRight]
                }
            } else {
                if index == 0 {
                    cornerRadius = style.cornerRadius
                    corners = [.bottomLeft]
                }
                
                if index == count-1 {
                    cornerRadius = style.cornerRadius
                    corners = [.bottomRight]
                }
            }
        }
    }
    
    private func applyLayout() {
        if let style = style {
            self.backgroundColor = style.malertButtonStyle.backgroundColor
            self.tintColor = style.malertButtonStyle.tintColor
            self.round(corners: corners, radius: cornerRadius, borderColor: style.malertButtonStyle.separetorColor, borderWidth: style.malertButtonStyle.separetorWidth)
        }
    }
    
    func buttonPressedAction(button: UIButton){
        if let actionBlock = actionBlock {
            actionBlock()
        }
    }
}

