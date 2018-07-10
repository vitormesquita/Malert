//
//  MalertViewController.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/11/16.
//
//

import UIKit

protocol MalertViewControllerCallback: class {
    func tappedToDismiss()
}

class MalertViewController: BaseMalertViewController {
    
    private lazy var visibleView: UIView = self.buildVisibleView()
    
    private weak var callback: MalertViewControllerCallback?
    private var tapToDismiss: Bool = false
    
    private var visibleViewConstraints: [NSLayoutConstraint] = []
    private var malertConstraints: [NSLayoutConstraint] = []
    
    private var malertView: MalertView? {
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
            malertView.translatesAutoresizingMaskIntoConstraints = false
            visibleView.addSubview(malertView)
            //            self.viewDidLayoutSubviews()
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
        if let malertView = malertView {
            
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
    
    @objc private func tapOnView(_ sender: UITapGestureRecognizer) {
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
        visibleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(visibleView)
        return visibleView
    }
}
