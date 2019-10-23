//
//  Malert+Constraints.swift
//  Malert
//
//  Created by Vitor Mesquita on 16/07/2018.
//

import UIKit

extension Malert {
   
   func makeContraints() {
      NSLayoutConstraint.deactivate(visibleViewConstraints)
      
      visibleViewConstraints = [
         visibleView.topAnchor.constraint(equalTo: view.topAnchor),
         visibleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         visibleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         visibleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -keyboardRect.size.height)
      ]
      
      NSLayoutConstraint.activate(visibleViewConstraints)
      visibleView.layoutIfNeeded()
      
      NSLayoutConstraint.deactivate(malertConstraints)
      malertConstraints = [
         malertView.centerXAnchor.constraint(equalTo: visibleView.centerXAnchor),
         malertView.centerYAnchor.constraint(equalTo: visibleView.centerYAnchor),
         malertView.trailingAnchor.constraint(equalTo: visibleView.trailingAnchor, constant: -16),
         malertView.leadingAnchor.constraint(equalTo: visibleView.leadingAnchor, constant: 16)
      ]
      
      if UIDevice.current.orientation.isLandscape {
         let topContraint = malertView.topAnchor.constraint(equalTo: visibleView.topAnchor, constant: 16)
         topContraint.priority = UILayoutPriority(900)
         malertConstraints.append(topContraint)
         
         let bottomConstraint = malertView.bottomAnchor.constraint(equalTo: visibleView.bottomAnchor, constant: -16)
         bottomConstraint.priority = UILayoutPriority(900)
         malertConstraints.append(bottomConstraint)
      }
      
      NSLayoutConstraint.activate(malertConstraints)
      malertView.layoutIfNeeded()
   }
}
