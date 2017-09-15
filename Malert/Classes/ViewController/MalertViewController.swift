//
//  MalertViewController.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/11/16.
//
//

import UIKit
import Cartography

protocol MalertViewControllerCallback: class {
    func tappedToDismiss()
}

class MalertViewController: BaseMalertViewController {

    fileprivate lazy var visibleView: UIView = self.buildVisibleView()
    
    fileprivate weak var callback: MalertViewControllerCallback?
    fileprivate var tapToDismiss: Bool = false
    fileprivate let bottomInsetConstraintGroup = ConstraintGroup()
    fileprivate let malertConstraintGroup = ConstraintGroup()
    
    fileprivate var malertView: MalertView? {
        willSet {
            if let malertView = malertView {
                malertView.removeFromSuperview()
            }
        }
        didSet {
            guard let malertView = malertView else {
                return
            }
            malertView.alpha = 1
            visibleView.addSubview(malertView)
            constrain(malertView, visibleView, replace: malertConstraintGroup) { (malert, container) in
                malert.center == container.center
                malert.left == container.left + 16
                malert.right == container.right - 16
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
        self.view.addGestureRecognizer(tapRecognizer)
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
        view.layoutIfNeeded()
    }
    
    override func keyboardWillHide(sender: NSNotification) {
        super.keyboardWillHide(sender: sender)
        view.setNeedsUpdateConstraints()
        view.layoutIfNeeded()
    }
    
    //MARK: TapToDismiss
    
    @objc fileprivate func tapOnView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        if let malertView = malertView, tapToDismiss == true {
            let point = sender.location(in: self.view)
            let isPointInMalertView = malertView.frame.contains(point)
            if !isPointInMalertView {
                callback?.tappedToDismiss()
            }
        }
    }
}

/**
 * Create visibleView to display MalertView util keyboard has appeared
 * Create MalertView with MalertInteractiveTransation to dismiss malert
 */
extension MalertViewController {
    
    func set(malertViewStruct: MalertViewStruct, interactor: MalertInteractiveTransition, callback: MalertViewControllerCallback) {
        self.malertView = MalertView.buildAlert(with: malertViewStruct)
        self.tapToDismiss = malertViewStruct.tapToDismiss
        self.callback = callback
    }
    
    func getMalertView() -> MalertView? {
        return malertView
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
