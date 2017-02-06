//
//  MalertManager.swift
//  Pods
//
//  Created by Vitor Mesquita on 01/11/16.
//
//

import UIKit

public class MalertManager {
    public static var shared = MalertManager()
    
    fileprivate var mainWindow: UIWindow?
    fileprivate var alertWindow: UIWindow?
    fileprivate var alertQueue = [MalertViewStruct]()
    fileprivate var hasAlertOnWindow = false
    fileprivate let showAlertQueue = DispatchQueue(label: "showAlertQueue")
    
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
    
    fileprivate func show(with malertViewStruct: MalertViewStruct) {
        showAlertQueue.sync {
            DispatchQueue.main.async{ [weak self] in
                guard let strongSelf = self else { return }
                
                if strongSelf.alertWindow == nil {
                    strongSelf.alertWindow = UIWindow(frame: UIScreen.main.bounds)
                    strongSelf.mainWindow = UIApplication.shared.keyWindow
                }
                
                if !strongSelf.hasAlertOnWindow {
                    strongSelf.hasAlertOnWindow = true
                    strongSelf.malertViewController.setMalertView(malertViewStruct: malertViewStruct)
                    strongSelf.alertWindow!.rootViewController = strongSelf.malertViewController
                    strongSelf.alertWindow!.windowLevel = UIWindowLevelAlert
                    strongSelf.alertWindow!.makeKeyAndVisible()
                    
                } else {
                    strongSelf.alertQueue.append(malertViewStruct)
                }
            }
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
     *  - malertConfiguration: optional configuration for single malert
     */
    public func show(customView: UIView, buttons: [MalertButtonStruct], animationType: MalertAnimationType = .modalBottom, malertConfiguration: MalertViewConfiguration? = nil) {
        let alert = MalertViewStruct(title: nil, customView: customView, buttons: buttons, animationType: animationType, malertViewConfiguration: malertConfiguration)
        show(with: alert)
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
    public func show(title: String, customView:UIView, buttons: [MalertButtonStruct], animationType: MalertAnimationType = .modalBottom, malertConfiguration: MalertViewConfiguration? = nil) {
        let alert = MalertViewStruct(title: title, customView: customView, buttons: buttons, animationType: animationType, malertViewConfiguration: malertConfiguration)
        show(with: alert)
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
    public func show(title: String, message: String, buttons: [MalertButtonStruct], malertConfiguration: MalertViewConfiguration? = nil, animationType: MalertAnimationType = .modalBottom) {
        
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        if let malertConfig = malertConfiguration {
            messageLabel.textColor = malertConfig.textColor
            messageLabel.textAlignment = malertConfig.textAlign
        } else {
            messageLabel.textAlignment = MalertView.appearance().textAlign
        }
        
        let alert = MalertViewStruct(title: title, customView: messageLabel, buttons: buttons, animationType: animationType, malertViewConfiguration: malertConfiguration)
        show(with: alert)
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
        showAlertQueue.sync {
            DispatchQueue.main.async{ [weak self] in
                guard let strongSelf = self else { return }
                guard let alertWindow = strongSelf.alertWindow else { return }
                
                if let alertToPresent = strongSelf.alertQueue.first {
                    strongSelf.hasAlertOnWindow = false
                    strongSelf.show(with: alertToPresent)
                    strongSelf.alertQueue.remove(at: 0)
                    
                } else {
                    
                    //                    MalertAnimation.buildSimpleDismissAnimation(with: alertWindow, completion: {[weak self] finished in
                    //                        guard let strongSelf = self else { return }
                    strongSelf.hasAlertOnWindow = false
                    alertWindow.rootViewController?.view.endEditing(true)
                    strongSelf.mainWindow?.makeKey()
                    strongSelf.alertWindow = nil
                    
                    if let completion = completion {
                        completion(true)
                    }
                    //                        })
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
