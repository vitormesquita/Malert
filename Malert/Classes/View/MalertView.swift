//
//  MalertView.swift
//  Pods
//
//  Created by Vitor Mesquita on 31/10/16.
//
//

import UIKit
import OAStackView
import Cartography

class MalertView: UIView {
    
    fileprivate var style: MalertStyle!
    
    fileprivate var buttonsStackView: OAStackView?
    fileprivate var titleLabel: UILabel?
    fileprivate var buttons = [MalertButton]()
    
    fileprivate var title: String? {
        didSet {
            guard let title = title else {
                return
            }
            initializeTitleLabel(title: title)
        }
    }
    
    fileprivate var customView: UIView? {
        willSet {
            if let customView = customView {
                customView.removeFromSuperview()
            }
        }
        didSet { configCustomView() }
    }
    
    fileprivate var buttonsConfig: [MalertButtonConfig]? {
        willSet {
            if let _ = buttonsConfig, let buttonsStackView = buttonsStackView {
                for button in buttons {
                    buttonsStackView.removeArrangedSubview(button)
                }
                buttonsStackView.removeFromSuperview()
                self.buttonsStackView = nil
                buttons = []
            }
        }
        didSet {
            guard let buttonsConfig = buttonsConfig else {
                return
            }
            
            let buttons = buttonsConfig.enumerated().map { (index, buttonConfig) -> MalertButton in
                let button = MalertButton(type: .system)
                button.initializeMalertButton(malertButtonConfig: buttonConfig, malertStyle: style, index: index, buttonsCount: buttonsConfig.count)
                return button
            }
            configStackViewOnAlert(buttons: buttons)
        }
    }
    
    init(style: MalertStyle){
        super.init(frame: .zero)
        self.style = style
        self.backgroundColor = style.backgroundColor
        self.layer.cornerRadius = style.cornerRadius
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    class func buildAlert(with title: String?, customView: UIView, buttons: [MalertButtonConfig], malertStyle:MalertStyle) -> MalertView {
        let alert = MalertView(style: malertStyle)
        alert.customView = customView
        alert.buttonsConfig = buttons
        alert.title = title
        return alert
    }
}

extension MalertView {
    
    fileprivate func initializeTitleLabel(title: String){
        titleLabel = UILabel()
        if let label = titleLabel {
            label.text = title
            label.textColor = style.textColor
            label.textAlignment = style.textAlign
            self.addSubview(label)
            constrain(label, self) { (label, containerView) in
                label.top == containerView.top + style.margin
                label.right == containerView.right - style.margin
                label.left == containerView.left + style.margin
            }
        }
    }
    
    fileprivate func configCustomView(){
        guard let customView = customView else {
            return
        }
        self.addSubview(customView)
        if let titleLabel = titleLabel {
            constrain(customView, titleLabel, self, block: { (customView, titleLabel, containerView) in
                customView.right == containerView.right - style.margin
                customView.left == containerView.left + style.margin
                customView.top == titleLabel.bottom + style.margin
            })
        } else {
            constrain(customView, self, block: { (customView, containerView) in
                customView.top == containerView.top + style.margin
                customView.right == containerView.right - style.margin
                customView.left == containerView.left + style.margin
            })
        }
    }
    
    fileprivate func configStackViewOnAlert(buttons: [MalertButton]){
        buttonsStackView = self.initializeButtonsStackView(with: buttons)
        
        if let buttonsStackView = buttonsStackView {
            self.addSubview(buttonsStackView)
            
            if let customView = customView {
                constrain(buttonsStackView, customView, self, block: { (containerStackView, customView, containerView) in
                    containerStackView.top == customView.bottom + style.margin
                    containerStackView.left == containerView.left + style.buttonsMargin
                    containerStackView.right == containerView.right - style.buttonsMargin
                    containerStackView.bottom == containerView.bottom - style.buttonsMargin
                })
            }
        }
    }
    
    fileprivate func initializeButtonsStackView(with buttons: [MalertButton]) -> OAStackView {
        let stack = OAStackView(arrangedSubviews: buttons)
        stack.distribution = style.buttonsDistribution
        stack.alignment = style.buttonsAligment
        stack.axis = style.buttonsAxis
        stack.spacing = style.buttonsSpace
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}
