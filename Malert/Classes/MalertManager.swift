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
    
    private var malertStyle: MalertStyle = MalertStyle()
    private var mainWindow: UIWindow?
    private var alertWindow: UIWindow?
    private var alertQueue = [MalertView]()
    
    private func show(with malertView: MalertView) {
        if alertWindow == nil {
            alertWindow = UIWindow(frame: UIScreen.main.bounds)
            mainWindow = UIApplication.shared.keyWindow
            if let alertWindow = alertWindow {
                let malertViewController = MalertViewController()
                malertViewController.setMalertView(malertView: malertView)
                alertWindow.rootViewController = malertViewController
                alertWindow.windowLevel = UIWindowLevelAlert
                alertWindow.makeKeyAndVisible()
                
                malertView.transform = CGAffineTransform.init(translationX: 9, y: alertWindow.bounds.size.height)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                    malertViewController.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
                    malertView.transform = .identity
                    }, completion: nil)
            }
        } else {
            alertQueue.append(malertView)
        }
    }
    
    public func setGlobalStyle(malertStyle: MalertStyle){
        self.malertStyle = malertStyle
    }
    
    public func show(with title: String, customView:UIView, buttons: [MalertButtonConfig] ) {
        let alert = MalertView.buildAlert(with: title, customView: customView, buttons: buttons, malertStyle: malertStyle)
        show(with: alert)
    }
    
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
                strongSelf.show(with: alertToPresent)
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
