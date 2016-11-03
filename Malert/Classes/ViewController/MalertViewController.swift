//
//  MalertViewController.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/11/16.
//
//

import UIKit
import Cartography

class MalertViewController: BaseMalertViewController {
    
    private let bottomInsetConstraintGroup = ConstraintGroup()
    private lazy var visibleView: UIView = self.buildVisibleView()
    
    private var malertView: MalertView? {
        didSet {
            guard let malertView = malertView else {
                return
            }
            visibleView.addSubview(malertView)
            constrain(malertView, visibleView) { (malertView, visibleView) in
                malertView.center == visibleView.center
                malertView.left == visibleView.left + 16
                malertView.right == visibleView.right - 16
            }
        }
    }
    
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listenKeyboard()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        constrain(view, visibleView, replace: bottomInsetConstraintGroup, block: { (view, visibleView) -> () in
            visibleView.bottom == view.bottom - keyboardRect.size.height
        })
    }
    
    override func keyboardWillShow(sender: NSNotification) {
        super.keyboardWillShow(sender: sender)
        view.setNeedsUpdateConstraints()
    }
    
    override func keyboardWillHide(sender: NSNotification) {
        super.keyboardWillHide(sender: sender)
        view.setNeedsUpdateConstraints()
    }
    
    func setMalertView(malertView: MalertView) {
        self.malertView = malertView
    }
    
    func buildVisibleView() -> UIView {
        let visibleView = UIView(frame: self.view.frame)
        view.addSubview(visibleView)
        constrain(visibleView, view) { (visibleView, containerView) in
            visibleView.top == containerView.top
            visibleView.right == containerView.right
            visibleView.left == containerView.left
        }
        return visibleView
    }
}
