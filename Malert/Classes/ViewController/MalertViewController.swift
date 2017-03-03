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

    fileprivate var tapToDismiss:Bool = false
    fileprivate let bottomInsetConstraintGroup = ConstraintGroup()
    fileprivate lazy var visibleView: UIView = self.buildVisibleView()
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
            constrain(malertView, visibleView) { (malertView, visibleView) in
                malertView.center == visibleView.center
                malertView.left == visibleView.left + 16
                malertView.right == visibleView.right - 16
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
    }
    
    override func keyboardWillHide(sender: NSNotification) {
        super.keyboardWillHide(sender: sender)
        view.setNeedsUpdateConstraints()
    }
    
    //MARK: TapToDismiss
    
    @objc fileprivate func tapOnView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        if let malertView = malertView, tapToDismiss == true {
            let point = sender.location(in: malertView)
            guard !malertView.point(inside: point, with: nil) else { return }
            Malert.shared.dismiss()
        }
    }
}

/**
 * Create visibleView to display MalertView util keyboard has appeared
 * Create MalertView with MalertInteractiveTransation to dismiss malert
 */
extension MalertViewController {
    
    func set(malertViewStruct: MalertViewStruct, interactor: MalertInteractiveTransition) {
        self.malertView = MalertView.buildAlert(with: malertViewStruct)
        self.tapToDismiss = malertViewStruct.tapToDismiss
//        if tapToDismiss {
//            let panRecognizer = UIPanGestureRecognizer(target: interactor, action: #selector(MalertInteractiveTransition.handlePan))
//            self.view.addGestureRecognizer(panRecognizer)
//        }
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
