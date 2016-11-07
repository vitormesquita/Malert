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
    fileprivate var alertQueue = [MalertView]()
    
    fileprivate func show(with malertView: MalertView, animationType:MalertAnimationType) {
        if alertWindow == nil {
            alertWindow = UIWindow(frame: UIScreen.main.bounds)
            mainWindow = UIApplication.shared.keyWindow
            if let alertWindow = alertWindow {
                let malertViewController = MalertViewController()
                malertViewController.setMalertView(malertView: malertView)
                alertWindow.rootViewController = malertViewController
                alertWindow.windowLevel = UIWindowLevelAlert
                alertWindow.makeKeyAndVisible()
                
                MalertAnimation.buildAnimation(with: MalertAnimationWrapper(animationType: animationType, malertView: malertView, malertViewController: malertViewController, malertWindow: alertWindow))
            }
        } else {
            alertQueue.append(malertView)
        }
    }
}

extension MalertManager {
    
    /**
     * Malert's functions about show alert with title or just with custom view
     * Parameters: 
     *  - title: String that will put on top to alert
     *  - customView: all UIView can be put here to appear in alert
     *  - buttons: Struct that will create all buttons in stackView 
     *  - animationType: the animation will apresent the alert in uiwindow
     */
    
    public func show(customView: UIView, buttons: [MalertButtonConfig], animationType: MalertAnimationType = .modalBottom) {
        let alert = MalertView.buildAlert(with: nil, customView: customView, buttons: buttons)
        show(with: alert, animationType: animationType)
    }

    public func show(title: String, customView:UIView, buttons: [MalertButtonConfig], animationType: MalertAnimationType = .modalBottom) {
        let alert = MalertView.buildAlert(with: title, customView: customView, buttons: buttons)
        show(with: alert, animationType: animationType)
    }
}

extension MalertManager {
    
    /**
     * Malert's functions to dismiss the current alert and show other or dismiss all alerts
     * Parameters: 
     *  - completion: Block with boolean that inform if animation is completed
     */
    
    public func dismiss(with completion: ((_ finished: Bool) -> Void)? = nil) {
        guard let alertWindow = alertWindow else { return }
        
        UIView.animate(withDuration: 0.25, animations: {
            alertWindow.alpha = 0
        }) {[weak self] (finished) in
            guard let strongSelf = self else { return }
            strongSelf.alertWindow?.rootViewController?.view.endEditing(true)
            strongSelf.mainWindow?.makeKey()
            strongSelf.alertWindow = nil
            
            if let alertToPresent = strongSelf.alertQueue.first {
                strongSelf.show(with: alertToPresent, animationType: .modalLeft)
                strongSelf.alertQueue.remove(at: 0)
            }
            
            if let completion = completion {
                completion(finished)
            }
        }
    }
    
    public func dismissAll() {
        alertQueue = [MalertView]()
        dismiss()
    }
}
