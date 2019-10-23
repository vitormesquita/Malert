//
//  MalertAction.swift
//  Malert
//
//  Created by Vitor Mesquita on 16/07/2018.
//

import UIKit

/// Class to build `MalertButtonView`
public class MalertAction {
   
   var title: String
   var actionBlock: (() -> ())?
   
   public var tintColor: UIColor?
   public var backgroundColor: UIColor?
   public var cornerRadius: CGFloat?
   public var borderColor: UIColor?
   public var borderWidth: CGFloat?
   
   public init(title: String, actionBlock: (() -> ())? = nil) {
      self.title = title
      self.actionBlock = actionBlock
   }
   
   public init(title: String, backgroundColor: UIColor, actionBlock: (() -> ())? = nil) {
      self.title = title
      self.backgroundColor = backgroundColor
      self.actionBlock = actionBlock
   }
}
