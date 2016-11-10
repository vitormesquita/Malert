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

public class MalertView: UIView {
    
    fileprivate lazy var titleLabel: UILabel = MalertView.initializeTitleLabel()
    fileprivate lazy var buttonsStackView: OAStackView = MalertView.initializeButtonsStackView()
    
    fileprivate var buttons = [MalertButton]()
    fileprivate var title: String?
    
    fileprivate var customView: UIView? {
        willSet {
            if let customView = customView {
                customView.removeFromSuperview()
            }
        }
    }
    
    fileprivate var buttonsConfig: [MalertButtonConfig]? {
        willSet {
            if let _ = buttonsConfig {
                for button in buttons {
                    buttonsStackView.removeArrangedSubview(button)
                }
                buttons = []
            }
        }
        didSet {
            guard let buttonsConfig = buttonsConfig else {
                return
            }
            
            buttons = buttonsConfig.enumerated().map { (index, buttonConfig) -> MalertButton in
                let button = MalertButton(type: .system)
                button.initializeMalertButton(malertButtonConfig: buttonConfig, index: index, isHorizontalAxis: buttonsAxis == .horizontal)
                return button
            }
        }
    }
    
    // MARK: - Appearance
    
    // Dialog view corner radius
    public dynamic var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    // Title text color
    public dynamic var textColor: UIColor {
        get { return titleLabel.textColor }
        set { titleLabel.textColor = newValue }
    }
    
    // Title text Align
    public dynamic var textAlign: NSTextAlignment {
        get { return titleLabel.textAlignment }
        set { titleLabel.textAlignment = newValue }
    }
    
    // Buttons distribution in stack view
    public dynamic var buttonsDistribution: OAStackViewDistribution {
        get { return buttonsStackView.distribution }
        set { buttonsStackView.distribution = newValue }
    }
    
    // Buttons aligns in stack view
    public dynamic var buttonsAligment: OAStackViewAlignment {
        get { return buttonsStackView.alignment }
        set { buttonsStackView.alignment = newValue }
    }
    
    // Buttons axis in stack view
    public dynamic var buttonsAxis: UILayoutConstraintAxis {
        get { return buttonsStackView.axis }
        set { buttonsStackView.axis = newValue }
    }
    
    //TODO
    public dynamic var margin: CGFloat = 16
    public dynamic var buttonsMargin: CGFloat = 0
    public dynamic var buttonsSpace: CGFloat = 0
    
    init(title: String?, customView: UIView, buttons: [MalertButtonConfig]) {
        super.init(frame: .zero)
        backgroundColor = .white
        layer.cornerRadius = 6
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.title = title
            strongSelf.customView = customView
            strongSelf.buttonsConfig = buttons
            strongSelf.setUpViews()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension MalertView {
    
    /**
     * Build and return MalertView
     * Parameters:
     *  - title: it's the dialog title. Whitout it wont appear the title
     *  - customView: Expect any UIView to put in dialog as content
     *  - buttons: Array of malert button struct to build buttons in alert
     */
    
    class func buildAlert(with malertViewStruct: MalertViewStruct) -> MalertView {
        let alert = MalertView(title: malertViewStruct.title, customView: malertViewStruct.customView, buttons: malertViewStruct.buttons)
        return alert
    }
}

extension MalertView {
    
    fileprivate func setUpViews() {
        setUpTitle()
        setUpCustomView()
        setUpButtonsStackView()
    }
    
    fileprivate func setUpTitle() {
        guard let title = title else {
            return
        }
        
        titleLabel.text = title
        self.addSubview(titleLabel)
        constrain(titleLabel, self) { (label, containerView) in
            label.top == containerView.top + margin
            label.right == containerView.right - margin
            label.left == containerView.left + margin
        }
    }
    
    fileprivate func setUpCustomView() {
        guard let customView = customView else {
            return
        }
        
        self.addSubview(customView)
        constrain(customView, titleLabel, self, block: { (customView, titleLabel, containerView) in
            customView.right == containerView.right - margin
            customView.left == containerView.left + margin
            if let _ = title {
                customView.top == titleLabel.bottom + margin
            } else {
                customView.top == containerView.top + margin
            }
        })
        
        if title == nil && margin == 0 {
            customView.round(corners: [.topLeft, .topRight], radius: cornerRadius)
        }
    }
    
    fileprivate func setUpButtonsStackView() {
        guard buttons.count > 0 else {
            return
        }
        
        for button in buttons {
            buttonsStackView.addArrangedSubview(button)
        }
        addSubview(buttonsStackView)
        if let customView = customView {
            constrain(buttonsStackView, customView, self, block: { (containerStackView, customView, containerView) in
                containerStackView.top == customView.bottom + margin
                containerStackView.left == containerView.left + buttonsMargin
                containerStackView.right == containerView.right - buttonsMargin
                containerStackView.bottom == containerView.bottom - buttonsMargin
            })
        }
    }
}

extension MalertView {
    
    fileprivate class func initializeTitleLabel() -> UILabel{
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }
    
    fileprivate class func initializeButtonsStackView() -> OAStackView {
        let stack = OAStackView()
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}
