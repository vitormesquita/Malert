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

class MalertButtonView: UIButton {
   
   var actionBlock: (() -> ())?
   weak var callback: MalertActionCallbackProtocol?
   
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
   
   //MARK: Action
   @objc private func buttonPressedAction(button: UIButton){
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
   
   func setUp(index: Int, hasMargin: Bool, isHorizontalAxis: Bool) {
      self.index = index
      self.isHorizontalAxis = isHorizontalAxis
      
      if !hasMargin {
         setUpSeparetorsViews()
      }
   }
   
   func setUpBy(action: MalertAction) {
      self.actionBlock = action.actionBlock
      
      if let tintColor = action.tintColor {
         self.tintColor = tintColor
      }
      
      if let backgroundColor = action.backgroundColor {
         self.backgroundColor = backgroundColor
      }
      
      if let cornerRadius = action.cornerRadius {
         self.layer.cornerRadius = cornerRadius
      }
      
      if let borderColor = action.borderColor {
         self.layer.borderColor = borderColor.cgColor
      }
      
      if let borderWidth = action.borderWidth {
         self.layer.borderWidth = borderWidth
      }
      
      setTitle(action.title, for: .normal)
      addTarget(self, action: #selector(MalertButtonView.buttonPressedAction(button:)), for: .touchUpInside)
   }
}

extension MalertButtonView {
   
   private func setUpSeparetorsViews() {
      translatesAutoresizingMaskIntoConstraints = false
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

extension MalertButtonView {
   
   // Button Height
   var height: CGFloat {
      get { return bounds.size.height }
      set { heightAnchor.constraint(equalToConstant: newValue).isActive = true }
   }
   
   // The separator color of this button
   var separetorColor: UIColor? {
      get { return separetor.backgroundColor }
      set {
         separetor.backgroundColor = newValue
         leftSeparetor.backgroundColor = newValue
      }
   }
   
   // Button font
   var titleFont: UIFont? {
      get { return titleLabel?.font }
      set { titleLabel?.font = newValue }
   }
}
