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
                
                var updatedButtonConfig = buttonConfig
                updatedButtonConfig.isHorizontalAxis = buttonsAxis == .horizontal
                updatedButtonConfig.index = index
                
                button.initializeMalertButton(malertButtonConfig: updatedButtonConfig)
                return button
            }
        }
    }
    
    fileprivate var inset: CGFloat = 0 {
        didSet {
            updateTitleLabelConstraints()
            updateCustomViewConstraints()
            updateButtonsStackViewConstraints()
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
    
    // Margin inset to titleLabel and CustomView
    public dynamic var margin: CGFloat {
        get { return inset }
        set { inset = newValue }
    }
    
    //TODO next upgrade
    //public dynamic var buttonsMargin: CGFloat = 0
    //public dynamic var buttonsSpace: CGFloat = 0
    
    init(title: String?, customView: UIView, buttons: [MalertButtonConfig], malertViewConfiguration: MalertViewConfiguration? = nil) {
        super.init(frame: .zero)
        backgroundColor = .white
        cornerRadius = 6
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.title = title
            strongSelf.customView = customView
            strongSelf.buttonsConfig = buttons
            strongSelf.setUpViews()
            
            if let malertViewConfiguration = malertViewConfiguration {
                strongSelf.setConfigurationInMalertView(malertViewConfig: malertViewConfiguration)
            }
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func setConfigurationInMalertView(malertViewConfig: MalertViewConfiguration) {
        backgroundColor = malertViewConfig.backgroundColor
        cornerRadius = malertViewConfig.cornerRadius
        textAlign = malertViewConfig.textAlign
        textColor = malertViewConfig.textColor
        buttonsDistribution = malertViewConfig.buttonDistribution
        buttonsAligment = malertViewConfig.buttonsAligment
        buttonsAxis = malertViewConfig.buttonsAxis
        margin = malertViewConfig.margin
    }
}

extension MalertView {
    
    /**
     * Build and return MalertView
     * Parameters:
     *  - malertViewStruct: Struct which contains title, customView, array of Buttons and if needed contains malertViewConfiguration
     */
    
    class func buildAlert(with malertViewStruct: MalertViewStruct) -> MalertView {
        let alert = MalertView(title: malertViewStruct.title, customView: malertViewStruct.customView, buttons: malertViewStruct.buttons, malertViewConfiguration: malertViewStruct.configuration)
        return alert
    }
}

extension MalertView {
    
    /**
     * Extensions to setUp Views in alert
     */
    
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
        updateTitleLabelConstraints()
    }
    
    fileprivate func setUpCustomView() {
        guard let customView = customView else {
            return
        }
        
        self.addSubview(customView)
        updateCustomViewConstraints()
        
        if title == nil && inset == 0 {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                customView.round(corners: [.topLeft, .topRight], radius: strongSelf.cornerRadius)
            }
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
        updateButtonsStackViewConstraints()
    }
}

extension MalertView {
    
    /**
     * Extensios that implements Malert constraints to:
     *  - Title Label
     *  - Custom View
     *  - Buttons Stack View
     */
    
    fileprivate func updateTitleLabelConstraints() {
        guard let _ = title else { return }
        
        constrain(titleLabel, self) { (label, containerView) in
            label.top == containerView.top + inset
            label.right == containerView.right - inset
            label.left == containerView.left + inset
        }
    }
    
    fileprivate func updateCustomViewConstraints() {
        guard let customView = customView else { return }
        
        constrain(customView, titleLabel, self, block: { (customView, titleLabel, containerView) in
            customView.right == containerView.right - inset
            customView.left == containerView.left + inset
            if let _ = title {
                customView.top == titleLabel.bottom + inset
            } else {
                customView.top == containerView.top + inset
            }
        })
    }
    
    fileprivate func updateButtonsStackViewConstraints() {
        if let customView = customView {
            constrain(buttonsStackView, customView, self, block: { (containerStackView, customView, containerView) in
                containerStackView.top == customView.bottom + inset
                containerStackView.left == containerView.left
                containerStackView.right == containerView.right
                containerStackView.bottom == containerView.bottom
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
