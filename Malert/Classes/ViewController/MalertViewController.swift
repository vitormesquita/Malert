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
    
    fileprivate let visibleViewConstraintGroup = ConstraintGroup()
    
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
            self.viewDidLayoutSubviews()
        }
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        listenKeyboard()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        constrain(view, visibleView, replace: visibleViewConstraintGroup, block: {[weak self] (view, visibleView) -> () in
            guard let strongSelf = self else { return }
            visibleView.top == view.top
            visibleView.right == view.right
            visibleView.left == view.left
            visibleView.bottom == view.bottom - strongSelf.keyboardRect.size.height
        })
        
        if let malertView = malertView {
            
            constrain(malertView, visibleView, replace: malertConstraintGroup) { (malert, container) in
                malert.center == container.center
                malert.left == container.left + 16
                malert.right == container.right - 16
                
                if UIDevice.current.orientation.isLandscape {
                    malert.top >= container.top + 16 ~ UILayoutPriority(900)
                    malert.bottom >= container.bottom - 16 ~ UILayoutPriority(900)
                }
            }
        }
    }
    
    override func keyboardWillShow(sender: NSNotification) {
        super.keyboardWillShow(sender: sender)
        self.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    override func keyboardWillHide(sender: NSNotification) {
        super.keyboardWillHide(sender: sender)
        self.viewDidLayoutSubviews()
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
        let visibleView = UIView()
        view.addSubview(visibleView)
        return visibleView
    }
}
