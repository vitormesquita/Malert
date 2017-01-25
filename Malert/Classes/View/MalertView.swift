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
    fileprivate var viewsConstraints = [NSLayoutConstraint]()
    
    fileprivate var title: String?
    fileprivate var customView: UIView? { willSet { if let customView = customView { customView.removeFromSuperview() } } }
    fileprivate var buttonsConfig: [MalertButtonStruct]? {
        willSet {
            if let _ = buttonsConfig {
                for button in buttons {
                    buttonsStackView.removeArrangedSubview(button)
                }
                buttons = []
            }
        }
        didSet {
            guard let buttonsConfig = buttonsConfig else { return }
            buildButtons(by: buttonsConfig)
        }
    }
    
    fileprivate var inset: CGFloat = 0 {
        didSet {
            removeConstraints(viewsConstraints)
            updateTitleLabelConstraints()
            updateCustomViewConstraints()
            updateButtonsStackViewConstraints()
        }
    }
    
    fileprivate var stackInset: CGFloat = 0 {
        didSet{
            removeConstraints(viewsConstraints)
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
    
    //Title font
    public dynamic var titleFont: UIFont {
        get { return titleLabel.font }
        set { titleLabel.font = newValue }
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
    
    // Margin inset to StackView buttons
    public dynamic var buttonsMargin: CGFloat {
        get { return stackInset }
        set { stackInset = newValue }
    }
    
    // Margin inset between buttons
    public dynamic var buttonsSpace: CGFloat {
        get { return buttonsStackView.spacing }
        set { buttonsStackView.spacing = newValue }
    }
    
    init(title: String?, customView: UIView, buttons: [MalertButtonStruct], malertViewConfiguration: MalertViewConfiguration? = nil) {
        super.init(frame: .zero)
        backgroundColor = .white
        cornerRadius = 6
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            if let malertViewConfiguration = malertViewConfiguration {
                strongSelf.setConfigurationInMalertView(malertViewConfig: malertViewConfiguration)
            }
            
            strongSelf.title = title
            strongSelf.customView = customView
            strongSelf.buttonsConfig = buttons
            strongSelf.setUpViews()
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
        buttonsAxis = malertViewConfig.buttonsAxis
        margin = malertViewConfig.margin
        buttonsMargin = malertViewConfig.buttonsMargin
        buttonsSpace = malertViewConfig.buttonsSpace
        titleFont = malertViewConfig.titleFont
        //buttonsDistribution = malertViewConfig.buttonDistribution
        //buttonsAligment = malertViewConfig.buttonsAligment
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

/**
 * Extensions to setUp Views in alert
 */
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
        updateTitleLabelConstraints()
    }
    
    fileprivate func setUpCustomView() {
        guard let customView = customView else {
            return
        }
        
        self.addSubview(customView)
        updateCustomViewConstraints()
        
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            if strongSelf.title == nil && strongSelf.inset == 0 {
                customView.round(corners: [.topLeft, .topRight], radius: strongSelf.cornerRadius)
            }
            
            if strongSelf.buttonsConfig == nil || strongSelf.buttonsConfig?.count == 0 {
                customView.round(corners: [.bottomLeft, .bottomRight], radius: strongSelf.cornerRadius)
            }
            
            if strongSelf.title == nil && strongSelf.inset == 0 && (strongSelf.buttonsConfig == nil || strongSelf.buttonsConfig?.count == 0) {
                customView.round(corners: [.allCorners], radius: strongSelf.cornerRadius)
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
    
    fileprivate func buildButtons(by buttonsStruct: [MalertButtonStruct]) {
        buttons = buttonsStruct.enumerated().map { (index, buttonStruct) -> MalertButton in
            let button = MalertButton(type: .system)
            var updatedButtonStruct = buttonStruct
            updatedButtonStruct.isHorizontalAxis = buttonsAxis == .horizontal
            updatedButtonStruct.index = index
            updatedButtonStruct.hasMargin = buttonsSpace > 0
            button.initializeMalertButton(malertButtonStruct: updatedButtonStruct)
            return button
        }
    }
}

/**
 * Extensios that implements Malert constraints to:
 *  - Title Label
 *  - Custom View
 *  - Buttons Stack View
 */
extension MalertView {
    
    fileprivate func updateTitleLabelConstraints() {
        guard let _ = title else { return }
        
        constrain(titleLabel, self) { (label, containerView) in
            viewsConstraints.append(label.top == containerView.top + inset)
            viewsConstraints.append(label.right == containerView.right - inset)
            viewsConstraints.append(label.left == containerView.left + inset)
        }
    }
    
    fileprivate func updateCustomViewConstraints() {
        guard let customView = customView else { return }
        
        constrain(customView, titleLabel, self, block: { (customView, titleLabel, containerView) in
            viewsConstraints.append(customView.right == containerView.right - inset)
            viewsConstraints.append(customView.left == containerView.left + inset)
            if let _ = title {
                viewsConstraints.append(customView.top == titleLabel.bottom + inset)
            } else {
                viewsConstraints.append(customView.top == containerView.top + inset)
            }
            
            if buttonsConfig == nil || buttonsConfig?.count == 0 {
                viewsConstraints.append(customView.bottom == containerView.bottom - inset)
            }
        })
    }
    
    fileprivate func updateButtonsStackViewConstraints() {
        if let customView = customView {
            constrain(buttonsStackView, customView, self, block: { (containerStackView, customView, containerView) in
                viewsConstraints.append(containerStackView.top == customView.bottom + inset)
                viewsConstraints.append(containerStackView.left == containerView.left + stackInset)
                viewsConstraints.append(containerStackView.right == containerView.right - stackInset)
                viewsConstraints.append(containerStackView.bottom == containerView.bottom - stackInset)
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
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}
