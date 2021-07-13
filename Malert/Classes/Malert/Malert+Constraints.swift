//
//  Malert+Constraints.swift
//  Malert
//
//  Created by Vitor Mesquita on 16/07/2018.
//

import UIKit

extension Malert {
    
    func makeContraints() {
        createVisibileViewContraints()
        createMalertViewContraints()
    }
    
    private func createVisibileViewContraints() {
        NSLayoutConstraint.deactivate(visibleViewConstraints)
        
        visibleViewConstraints = [
            visibleView.topAnchor.constraint(equalTo: view.topAnchor),
            visibleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visibleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visibleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -keyboardRect.size.height)
        ]
        
        NSLayoutConstraint.activate(visibleViewConstraints)
        visibleView.layoutIfNeeded()
    }
    
    private func createMalertViewContraints() {
        NSLayoutConstraint.deactivate(malertConstraints)
        malertConstraints = isLandscapeEnable ? createMalertLandscapeConstraints() : createMalertPortraitConstraints()
        NSLayoutConstraint.activate(malertConstraints)
        malertView.layoutIfNeeded()
    }
    
    private var isLandscapeEnable: Bool {
        UIDevice.current.orientation.isLandscape &&
            !preferredInterfaceOrientationForPresentation.isPortrait
    }
    
    private func createMalertPortraitConstraints() -> [NSLayoutConstraint] {
        return [
            malertView.centerXAnchor.constraint(equalTo: visibleView.centerXAnchor),
            malertView.centerYAnchor.constraint(equalTo: visibleView.centerYAnchor),
            malertView.trailingAnchor.constraint(equalTo: visibleView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            malertView.leadingAnchor.constraint(equalTo: visibleView.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ]
    }
    
    private func createMalertLandscapeConstraints() -> [NSLayoutConstraint] {
        return [
            malertView.centerXAnchor.constraint(equalTo: visibleView.centerXAnchor),
            malertView.centerYAnchor.constraint(equalTo: visibleView.centerYAnchor),
            malertView.leadingAnchor.constraint(greaterThanOrEqualTo: visibleView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            malertView.trailingAnchor.constraint(greaterThanOrEqualTo: visibleView.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            malertView.topAnchor.constraint(greaterThanOrEqualTo: visibleView.safeAreaLayoutGuide.topAnchor, constant: 16),
            malertView.bottomAnchor.constraint(greaterThanOrEqualTo: visibleView.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ]
    }
}
