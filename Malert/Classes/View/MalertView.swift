//
//  MalertView.swift
//  Pods
//
//  Created by Vitor Mesquita on 31/10/16.
//
//

import UIKit

public class MalertView: UIView {
    
    private lazy var titleLabel = UILabel.ilimitNumberOfLines()
    private lazy var buttonsStackView = UIStackView.defaultStack(axis: .vertical)
    
    private var titleLabelConstraints: [NSLayoutConstraint] = []
    private var customViewConstraints: [NSLayoutConstraint] = []
    private var stackConstraints: [NSLayoutConstraint] = []
    
    private var viewsConfigurated = false
    
    private var hasButtons: Bool {
        if let buttons = buttons {
            return !buttons.isEmpty
        }
        
        return false
    }
    
    private var title: String?
    
    private var customView: UIView? {
        willSet {
            if let customView = customView {
                customView.removeFromSuperview()
            }
        }
    }
    
    private var buttons: [MalertButtonView]? {
        willSet {
            if let buttons = buttons {
                for button in buttons {
                    buttonsStackView.removeArrangedSubview(button)
                }
            }
        }
    }
    
    private var inset: CGFloat = 0 {
        didSet {
            refreshViews()
        }
    }
    
    private var stackInset: CGFloat = 0 {
        didSet{
            refreshViews()
        }
    }
    
    init(title: String?,
         customView: UIView?,
         buttons: [MalertButton]?,
         malertViewConfiguration: MalertViewConfiguration? = nil) {
        
        super.init(frame: .zero)
        
        clipsToBounds = true
        backgroundColor = .white
        cornerRadius = 6
        
        if let malertViewConfiguration = malertViewConfiguration {
            setConfigurationInMalertView(malertViewConfig: malertViewConfiguration)
        }
        
        self.title = title
        self.customView = customView
        self.buttons = Helper.buildButtonsBy(buttons: buttons,
                                             hasMargin: buttonsSpace > 0,
                                             isHorizontalAxis: buttonsAxis == .horizontal)
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.setUpTitle()
            strongSelf.setUpCustomView()
            strongSelf.setUpButtonsStackView()
            
            strongSelf.viewsConfigurated = true
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK - Utils
    
    private func setConfigurationInMalertView(malertViewConfig: MalertViewConfiguration) {
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
    
    private func refreshViews() {
        updateTitleLabelConstraints()
        updateCustomViewConstraints()
        updateButtonsStackViewConstraints()
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
    
    private func setUpTitle() {
        guard let title = title else {
            return
        }
        
        titleLabel.text = title
        self.addSubview(titleLabel)
        updateTitleLabelConstraints()
    }
    
    private func setUpCustomView() {
        guard let customView = customView else {
            return
        }
        
        self.addSubview(customView)
        updateCustomViewConstraints()
    }
    
    private func setUpButtonsStackView() {
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
    
    private func updateTitleLabelConstraints() {
        guard let _ = title else { return }
        
        NSLayoutConstraint.deactivate(titleLabelConstraints)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
    private func updateCustomViewConstraints() {
        guard let customView = customView else { return }
        
        NSLayoutConstraint.deactivate(customViewConstraints)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customViewConstraints = [
            customView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            customView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset)
        ]
        
        if titleLabel.isDescendant(of: self) {
            customViewConstraints.append(customView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: inset))
        } else {
            customViewConstraints.append(customView.topAnchor.constraint(equalTo: self.topAnchor, constant: inset))
        }
        
        if !hasButtons {
            customViewConstraints.append(customView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset))
        }
        
        NSLayoutConstraint.activate(customViewConstraints)
    }
    
    private func updateButtonsStackViewConstraints() {
        if let customView = customView, hasButtons {
            
            NSLayoutConstraint.deactivate(stackConstraints)
            buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
            stackConstraints = [
                buttonsStackView.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: inset),
                buttonsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -stackInset),
                buttonsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: stackInset),
                buttonsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -stackInset)
            ]
            
            NSLayoutConstraint.activate(stackConstraints)
        }
    }
}

// MARK: - Appearance

extension MalertView {
    
    // Dialog view corner radius
    @objc public dynamic var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    // Title text color
    @objc public dynamic var textColor: UIColor {
        get { return titleLabel.textColor }
        set { titleLabel.textColor = newValue }
    }
    
    // Title text Align
    @objc public dynamic var textAlign: NSTextAlignment {
        get { return titleLabel.textAlignment }
        set { titleLabel.textAlignment = newValue }
    }
    
    //Title font
    @objc public dynamic var titleFont: UIFont {
        get { return titleLabel.font }
        set { titleLabel.font = newValue }
    }
    
    // Buttons distribution in stack view
    @objc public dynamic var buttonsDistribution: UIStackViewDistribution {
        get { return buttonsStackView.distribution }
        set { buttonsStackView.distribution = newValue }
    }
    
    // Buttons aligns in stack view
    @objc public dynamic var buttonsAligment: UIStackViewAlignment {
        get { return buttonsStackView.alignment }
        set { buttonsStackView.alignment = newValue }
    }
    
    // Buttons axis in stack view
    @objc public dynamic var buttonsAxis: UILayoutConstraintAxis {
        get { return buttonsStackView.axis }
        set { buttonsStackView.axis = newValue }
    }
    
    // Margin inset to titleLabel and CustomView
    @objc public dynamic var margin: CGFloat {
        get { return inset }
        set { inset = newValue }
    }
    
    // Margin inset to StackView buttons
    @objc public dynamic var buttonsMargin: CGFloat {
        get { return stackInset }
        set { stackInset = newValue }
    }
    
    // Margin inset between buttons
    @objc public dynamic var buttonsSpace: CGFloat {
        get { return buttonsStackView.spacing }
        set { buttonsStackView.spacing = newValue }
    }
}
