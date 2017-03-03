//
//  MalertManager.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/11/16.
//
//

import UIKit

public class Malert: NSObject {
    public static var shared = Malert()

    fileprivate var alertQueue = [MalertViewStruct]()
    fileprivate var hasAlertOnWindow = false
    
    fileprivate var viewControllerToPresent: UIViewController?
    fileprivate var malertViewController: MalertViewController?    
    fileprivate let malertPresentationManager = MalertPresentationManager()
    fileprivate lazy var interactor = MalertInteractiveTransition()
    
    /**
     * Function to init MalertWindow if needed and verify if has any MalertView with other ViewController
     * If has put next MalertView on queue.
     * If haven't shown MalertView
     * Parameters:
     *  - view
     *  - malertViewStruct: Struct to represent MalertView with yours attributes
     *  - animationType: MalertAnimationType that MalertView will be apresented
     */
    fileprivate func show(with viewController: UIViewController, malertViewStruct: MalertViewStruct) {
        self.viewControllerToPresent = viewController
        
        if !hasAlertOnWindow {
            hasAlertOnWindow = true
            malertPresentationManager.animationType = malertViewStruct.animationType
//            malertPresentationManager.interactor = interactor
            
            if malertViewController == nil {
                malertViewController = MalertViewController()
                malertViewController!.modalPresentationStyle = .custom
                malertViewController!.transitioningDelegate = malertPresentationManager
//                interactor.viewController = malertViewController
            }
            
            malertViewController!.set(malertViewStruct: malertViewStruct, interactor: interactor)
            viewController.present(malertViewController!, animated: true, completion: nil)
            
        } else {
            alertQueue.append(malertViewStruct)
        }
    }
}

extension Malert {
    
    /**
     * Show alert without Title, just customView
     * Parameters:
     *  - customView: all UIView can be put here to appear in alert
     *  - buttons: Struct that will create all buttons in stackView
     *  - animationType: the animation will apresent the alert in uiwindow
     *  - malertConfiguration: optional configuration for single malert
     */
    public func show(viewController: UIViewController, customView: UIView, buttons: [MalertButtonStruct], animationType: MalertAnimationType = .modalBottom, malertConfiguration: MalertViewConfiguration? = nil, tapToDismiss:Bool = true) {
        
        let alert = MalertViewStruct(title: nil,
                                     customView: customView,
                                     buttons: buttons,
                                     animationType: animationType,
                                     malertViewConfiguration: malertConfiguration,
                                     tapToDismiss: tapToDismiss)
        
        show(with: viewController, malertViewStruct: alert)
    }
    
    /**
     * Show alert with title
     * Parameters:
     *  - title: String that will put on top to alert
     *  - customView: all UIView can be put here to appear in alert
     *  - buttons: Struct that will create all buttons in stackView
     *  - animationType: the animation will apresent the alert in uiwindow
     *  - malertConfiguration: optional configuration for single malert
     */
    public func show(viewController: UIViewController, title: String, customView:UIView, buttons: [MalertButtonStruct], animationType: MalertAnimationType = .modalBottom, malertConfiguration: MalertViewConfiguration? = nil, tapToDismiss:Bool = true) {
        
        let alert = MalertViewStruct(title: title,
                                     customView: customView,
                                     buttons: buttons,
                                     animationType: animationType,
                                     malertViewConfiguration: malertConfiguration,
                                     tapToDismiss: tapToDismiss)
        
        show(with: viewController, malertViewStruct: alert)
    }
    
    /**
     * Show alert with title and message
     * Parameters:
     *  - title: String that will put on top to alert
     *  - message: String which will create messageLabel
     *  - buttons: Struct that will create all buttons in stackView
     *  - malertConfiguration: optional configuration for single malert
     *  - animationType: the animation will apresent the alert in uiwindow
     */
    public func show(viewController: UIViewController, title: String, message: String, buttons: [MalertButtonStruct], animationType: MalertAnimationType = .modalBottom, malertConfiguration: MalertViewConfiguration? = nil, tapToDismiss:Bool = true) {
        
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        if let malertConfig = malertConfiguration {
            messageLabel.textColor = malertConfig.textColor
            messageLabel.textAlignment = malertConfig.textAlign
        } else {
            messageLabel.textAlignment = MalertView.appearance().textAlign
        }
        
        let alert = MalertViewStruct(title: title, customView: messageLabel, buttons: buttons, animationType: animationType, malertViewConfiguration: malertConfiguration, tapToDismiss: tapToDismiss)
        show(with: viewController, malertViewStruct: alert)
    }
}

extension Malert {
    
    /**
     * Function to dismiss current MalertView shown.
     * Verify if has more alerts to show. Show if has or deinit MalertUIWindow if not
     * Parameters:
     *  - completion: Block with boolean that inform if animation is completed
     */
    public func dismiss(with completion: ((_ finished: Bool) -> Void)? = nil) {
        
        if let malertViewController = malertViewController {
            
            malertViewController.view.endEditing(true)
            malertViewController.dismiss(animated: true) {[weak self] in
                guard let strongSelf = self else {return}
                strongSelf.malertViewController = nil
                
                if let alertToPresent = strongSelf.alertQueue.first, let vc = strongSelf.viewControllerToPresent {
                    strongSelf.hasAlertOnWindow = false
                    strongSelf.show(with: vc, malertViewStruct: alertToPresent)
                    strongSelf.alertQueue.remove(at: 0)
                    
                } else {
                    strongSelf.hasAlertOnWindow = false
                    if let completion = completion {
                        completion(true)
                    }
                }
            }
        }
    }
    
    /**
     * Function to dismiss all MalertView
     */
    public func dismissAll() {
        alertQueue = [MalertViewStruct]()
        dismiss()
    }
}
