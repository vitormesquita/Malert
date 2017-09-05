//
//  MalertView.swift
//  Pods
//
//  Created by Vitor Mesquita on 31/10/16.
//
//

import UIKit
import Cartography

public class MalertView: UIView {
    
    fileprivate lazy var titleLabel = UILabel.ilimitNumberOfLines()
    fileprivate lazy var buttonsStackView = UIStackView.defaultStack(axis: .vertical)
    
    fileprivate var titleLabelConstraintGroup = ConstraintGroup()
    fileprivate var customViewConstraintGroup = ConstraintGroup()
    fileprivate var stackConstraintGroup = ConstraintGroup()
    
    fileprivate var viewsSetupped = false
    
    fileprivate var hasButtons: Bool {
        if let buttons = buttons {
            return !buttons.isEmpty
        }
        
        return false
    }
    
    fileprivate var title: String?
    
    fileprivate var customView: UIView? {
        willSet {
            if let customView = customView {
                customView.removeFromSuperview()
            }
        }
    }
    
    fileprivate var buttons: [MalertButton]? {
        willSet {
            if let buttons = buttons {
                for button in buttons {
                    buttonsStackView.removeArrangedSubview(button)
                }
            }
        }
    }
    
    fileprivate var inset: CGFloat = 0 {
        didSet {
            refreshViews()
        }
    }
    
    fileprivate var stackInset: CGFloat = 0 {
        didSet{
            refreshViews()
        }
    }
    
    init(title: String?,
         customView: UIView?,
         buttons: [MalertButtonStruct]?,
         malertViewConfiguration: MalertViewConfiguration? = nil) {
        
        super.init(frame: .zero)
        
        backgroundColor = .white
        cornerRadius = 6
        
        if let malertViewConfiguration = malertViewConfiguration {
            setConfigurationInMalertView(malertViewConfig: malertViewConfiguration)
        }
        
        self.title = title
        self.customView = customView
        self.buttons = Helper.buildButtonsBy(buttonsStruct: buttons,
                                             hasMargin: buttonsSpace > 0,
                                             isHorizontalAxis: buttonsAxis == .horizontal)
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            
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
    
    fileprivate func refreshViews() {
        //        removeConstraints(viewsConstraints)
        updateTitleLabelConstraints()
        updateCustomViewConstraints()
        updateButtonsStackViewConstraints()
    }
    
    
    fileprivate func customViewCorners() {
        guard let customView = customView else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            
            if strongSelf.title == nil && strongSelf.inset == 0 {
                customView.round(corners: [.topLeft, .topRight], radius: strongSelf.cornerRadius)
            }
            
            if !strongSelf.hasButtons {
                customView.round(corners: [.bottomLeft, .bottomRight], radius: strongSelf.cornerRadius)
            }
            
            if strongSelf.title == nil && strongSelf.inset == 0 && !strongSelf.hasButtons {
                customView.round(corners: [.allCorners], radius: strongSelf.cornerRadius)
            }
        }
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
        
        viewsSetupped = true
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
    }
    
    fileprivate func setUpButtonsStackView() {
        guard hasButtons else { return }
        
        for button in buttons! {
            buttonsStackView.addArrangedSubview(button)
        }
        
        self.addSubview(buttonsStackView)
        updateButtonsStackViewConstraints()
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
        
        constrain(titleLabel, self, replace: titleLabelConstraintGroup) { (label, containerView) in
            label.top == containerView.top + inset
            label.right == containerView.right - inset
            label.left == containerView.left + inset
        }
        
        titleLabel.layoutIfNeeded()
    }
    
    fileprivate func updateCustomViewConstraints() {
        guard let customView = customView else { return }
        customViewCorners()
        
        if titleLabel.isDescendant(of: self) {
            
            constrain(customView, titleLabel, self, replace: customViewConstraintGroup, block: { (view, title, container) in
                view.right == container.right - inset
                view.left == container.left + inset
                view.top == title.bottom + inset
                if !hasButtons {
                    view.bottom == container.bottom - inset
                }
            })
        } else {
            
            constrain(customView, self, replace: customViewConstraintGroup, block: { (view, container) in
                view.right == container.right - inset
                view.left == container.left + inset
                view.top == container.top + inset
                if !hasButtons {
                    view.bottom == container.bottom - inset
                }
            })
        }
        
        customView.layoutIfNeeded()
    }
    
    fileprivate func updateButtonsStackViewConstraints() {
        if let customView = customView, hasButtons {
            
            constrain(buttonsStackView, customView, self, replace: stackConstraintGroup, block: { (stack, custom, container) in
                stack.top == custom.bottom + inset
                stack.left == container.left + stackInset
                stack.right == container.right - stackInset
                stack.bottom == container.bottom - stackInset
            })
            
            buttonsStackView.layoutIfNeeded()
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if viewsSetupped {
            refreshViews()
            self.layoutIfNeeded()
        }
    }
}

// MARK: - Appearance

extension MalertView {
    
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
    public dynamic var buttonsDistribution: UIStackViewDistribution {
        get { return buttonsStackView.distribution }
        set { buttonsStackView.distribution = newValue }
    }
    
    // Buttons aligns in stack view
    public dynamic var buttonsAligment: UIStackViewAlignment {
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
}
