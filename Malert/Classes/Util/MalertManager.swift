//
//  MalertManager.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/11/16.
//
//

import UIKit

public class MalertManager {
    public static var sharedInstance = MalertManager()
    
    fileprivate var mainWindow: UIWindow?
    fileprivate var alertWindow: UIWindow?
    fileprivate var alertQueue = [MalertViewStruct]()
    fileprivate var hasAlertOnWindow = false
    
    fileprivate lazy var malertViewController: MalertViewController = {
        return MalertViewController()
    }()
    
    /**
     * Function to init MalertWindow if needed and verify if has any MalertView on Window.
     * If has put next MalertView on queue.
     * If don't have show MalertView on Window
     * Parameters: 
     *  - malertViewStruct: Struct to represent MalertView with yours attributes
     *  - animationType: MalertAnimationType that MalertView will be apresented
     */
    
    fileprivate func show(with malertViewStruct: MalertViewStruct, animationType:MalertAnimationType) {
        if alertWindow == nil {
            alertWindow = UIWindow(frame: UIScreen.main.bounds)
            mainWindow = UIApplication.shared.keyWindow
        }
        
        if !hasAlertOnWindow {
            hasAlertOnWindow = true
            malertViewController.setMalertView(malertViewStruct: malertViewStruct, animationType: animationType)
            alertWindow!.rootViewController = malertViewController
            alertWindow!.windowLevel = UIWindowLevelAlert
            alertWindow!.makeKeyAndVisible()
            
        } else {
            alertQueue.append(malertViewStruct)
        }
    }
}

extension MalertManager {
    
    /**
     * Show alert without Title, just customView
     * Parameters:
     *  - customView: all UIView can be put here to appear in alert
     *  - buttons: Struct that will create all buttons in stackView
     *  - animationType: the animation will apresent the alert in uiwindow
     */
    
    public func show(customView: UIView, buttons: [MalertButtonConfig], animationType: MalertAnimationType = .modalBottom) {
        let alert = MalertViewStruct(title: nil, customView: customView, buttons: buttons)
        show(with: alert, animationType: animationType)
    }
    
    /**
     * Show alert with title
     * Parameters:
     *  - title: String that will put on top to alert
     *  - customView: all UIView can be put here to appear in alert
     *  - buttons: Struct that will create all buttons in stackView
     *  - animationType: the animation will apresent the alert in uiwindow
     */
    
    public func show(title: String, customView:UIView, buttons: [MalertButtonConfig], animationType: MalertAnimationType = .modalBottom) {
        let alert = MalertViewStruct(title: title, customView: customView, buttons: buttons)
        show(with: alert, animationType: animationType)
    }
}

extension MalertManager {
    
    /**
     * Function to dismiss current MalertView shown.
     * Verify if has more alerts to show. Show if has or deinit MalertUIWindow if not
     * Parameters:
     *  - completion: Block with boolean that inform if animation is completed
     */
    
    public func dismiss(with completion: ((_ finished: Bool) -> Void)? = nil) {
        guard let alertWindow = alertWindow else { return }
        
        if let alertToPresent = alertQueue.first {
            hasAlertOnWindow = false
            show(with: alertToPresent, animationType: .modalBottom)
            alertQueue.remove(at: 0)
            
        } else {
            
            MalertAnimation.buildSimpleDismissAnimation(with: alertWindow, completion: {[weak self] finished in
                guard let strongSelf = self else { return }
                strongSelf.hasAlertOnWindow = false
                strongSelf.alertWindow?.rootViewController?.view.endEditing(true)
                strongSelf.mainWindow?.makeKey()
                strongSelf.alertWindow = nil
                
                if let completion = completion {
                    completion(finished)
                }
            })
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
