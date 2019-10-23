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
   
   private var stackConstraints: [NSLayoutConstraint] = []
   private var titleLabelConstraints: [NSLayoutConstraint] = []
   private var customViewConstraints: [NSLayoutConstraint] = []
   
   private var _buttonsHeight: CGFloat = 44
   private var _buttonsSeparetorColor: UIColor = UIColor(white: 0.8, alpha: 1)
   private var _buttonsFont: UIFont = UIFont.systemFont(ofSize: 16)
   
   private var inset: CGFloat = 0 {
      didSet { refreshViews() }
   }
   
   private var stackSideInset: CGFloat = 0 {
      didSet { updateButtonsStackViewConstraints() }
   }
   
   private var stackBottomInset: CGFloat = 0 {
      didSet { updateButtonsStackViewConstraints() }
   }
   
   private var customView: UIView? {
      didSet {
         if let oldValue = oldValue {
            oldValue.removeFromSuperview()
         }
      }
   }
   
   init() {
      super.init(frame: .zero)
      
      clipsToBounds = true
      
      //TODO Verificar se não não sobreescreve o appearence
      margin = 0
      cornerRadius = 6
      backgroundColor = .white
      textColor = .black
      textAlign = .left
      titleFont = UIFont.systemFont(ofSize: 14)
      buttonsSpace = 0
      buttonsSideMargin = 0
      buttonsAxis = .vertical
      //TODO Verificar se não não sobreescreve o appearence
   }
   
   required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
   
   //MARK - Utils
   
   private var hasButtons: Bool {
      guard buttonsStackView.isDescendant(of: self) else { return false }
      return !buttonsStackView.arrangedSubviews.isEmpty
   }
   
   private func refreshViews() {
      updateTitleLabelConstraints()
      updateCustomViewConstraints()
      updateButtonsStackViewConstraints()
   }
}

// MARK: - Extensions to setUp Views in alert
extension MalertView {
   
   func seTitle(_ title: String?) {
      if let title = title {
         titleLabel.text = title
         
         if !titleLabel.isDescendant(of: self) {
            self.addSubview(titleLabel)
            refreshViews()
         }
      }
   }
   
   func setCustomView(_ customView: UIView?) {
      guard let customView = customView else { return }
      self.customView = customView
      self.addSubview(customView)
      refreshViews()
   }
   
   func addButton(_ button: MalertAction, actionCallback: MalertActionCallbackProtocol?) {
      let buttonView = MalertButtonView(type: .system)
      buttonView.height = _buttonsHeight
      buttonView.titleFont = _buttonsFont
      buttonView.separetorColor = _buttonsSeparetorColor
      buttonView.callback = actionCallback
      
      buttonView.setUpBy(action: button)
      buttonView.setUp(index: buttonsStackView.arrangedSubviews.count, hasMargin: buttonsSpace > 0, isHorizontalAxis: buttonsAxis == .horizontal)
      
      buttonsStackView.addArrangedSubview(buttonView)
      
      if !buttonsStackView.isDescendant(of: self) {
         self.addSubview(buttonsStackView)
         refreshViews()
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
   
   private func updateTitleLabelConstraints() {
      NSLayoutConstraint.deactivate(titleLabelConstraints)
      guard titleLabel.isDescendant(of: self) else { return }
      
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
      if hasButtons {
         
         NSLayoutConstraint.deactivate(stackConstraints)
         buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
         stackConstraints = [
            buttonsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -stackSideInset),
            buttonsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: stackSideInset),
            buttonsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -stackBottomInset)
         ]
         
         if let customView = customView {
            stackConstraints.append(buttonsStackView.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: inset))
         } else if titleLabel.isDescendant(of: self) {
            stackConstraints.append(buttonsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: inset))
         } else {
            stackConstraints.append(buttonsStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: inset))
         }
         
         NSLayoutConstraint.activate(stackConstraints)
      }
   }
}

// MARK: - Appearance
extension MalertView {
   
   /// Dialog view corner radius
   @objc public dynamic var cornerRadius: CGFloat {
      get { return layer.cornerRadius }
      set { layer.cornerRadius = newValue }
   }
   
   /// Title text color
   @objc public dynamic var textColor: UIColor {
      get { return titleLabel.textColor }
      set { titleLabel.textColor = newValue }
   }
   
   /// Title text Align
   @objc public dynamic var textAlign: NSTextAlignment {
      get { return titleLabel.textAlignment }
      set { titleLabel.textAlignment = newValue }
   }
   
   /// Title font
   @objc public dynamic var titleFont: UIFont {
      get { return titleLabel.font }
      set { titleLabel.font = newValue }
   }
   
   /// Buttons distribution in stack view
   @objc public dynamic var buttonsDistribution: UIStackView.Distribution {
      get { return buttonsStackView.distribution }
      set { buttonsStackView.distribution = newValue }
   }
   
   /// Buttons aligns in stack view
   @objc public dynamic var buttonsAligment: UIStackView.Alignment {
      get { return buttonsStackView.alignment }
      set { buttonsStackView.alignment = newValue }
   }
   
   /// Buttons axis in stack view
   @objc public dynamic var buttonsAxis: NSLayoutConstraint.Axis {
      get { return buttonsStackView.axis }
      set { buttonsStackView.axis = newValue }
   }
   
   /// Margin inset to titleLabel and CustomView
   @objc public dynamic var margin: CGFloat {
      get { return inset }
      set { inset = newValue }
   }
   
   /// Trailing and Leading margin inset to StackView buttons
   @objc public dynamic var buttonsSideMargin: CGFloat {
      get { return stackSideInset }
      set { stackSideInset = newValue }
   }
   
   /// Bottom margin inset to StackView buttons
   @objc public dynamic var buttonsBottomMargin: CGFloat {
      get { return stackBottomInset }
      set { stackBottomInset = newValue }
   }
   
   /// Margin inset between buttons
   @objc public dynamic var buttonsSpace: CGFloat {
      get { return buttonsStackView.spacing }
      set { buttonsStackView.spacing = newValue }
   }
   
   ///
   @objc public dynamic var buttonsHeight: CGFloat {
      get { return _buttonsHeight }
      set { _buttonsHeight = newValue }
   }
   
   ///
   @objc public dynamic var separetorColor: UIColor {
      get { return _buttonsSeparetorColor }
      set { _buttonsSeparetorColor = newValue }
   }
   
   ///
   @objc public dynamic var buttonsFont: UIFont {
      get { return _buttonsFont }
      set { _buttonsFont = newValue }
   }
}
