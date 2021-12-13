//
//  BaseViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/18.
//

import UIKit
import IQKeyboardManagerSwift

class BaseViewController: UIViewController {
    
    static var identifier: String {
        
        return String(describing: self)
    }
    
    var isEnableResignOnTouchOutside: Bool {
        
        return true
    }
    
    var isEnableIQKeyboard: Bool {
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isEnableIQKeyboard {
            IQKeyboardManager.shared.enable = false
        } else {
            IQKeyboardManager.shared.enable = true
        }
        
        if !isEnableResignOnTouchOutside {
            IQKeyboardManager.shared.shouldResignOnTouchOutside = false
        } else {
            IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        }
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !isEnableIQKeyboard {
            IQKeyboardManager.shared.enable = true
        } else {
            IQKeyboardManager.shared.enable = false
        }
        
        if !isEnableResignOnTouchOutside {
            IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        } else {
            IQKeyboardManager.shared.enable = false
        }
    }
    
    @IBAction func popBack(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backToRoot(_ sender: Any) {
        
        backToRoot(completion: nil)
    }
}

extension UIViewController {
    
    func backToRoot(completion: (() -> Void)? = nil) {
        
        if presentingViewController != nil {
            
            let superVC = presentingViewController
            
            dismiss(animated: false, completion: nil)
            
            superVC?.backToRoot(completion: completion)
            
            return
        }
        
        if let tabbarVC = self as? UITabBarController {
            
            tabbarVC.selectedViewController?.backToRoot(completion: completion)
            
            return
        }
        
        if let navigateVC = self as? UINavigationController {
            
            navigateVC.popToRootViewController(animated: false)
        }
        
        completion?()
    }
}

extension UIViewController {
    
    func setupGradientBackground() {
        
         let gradientLayer = CAGradientLayer()
        
         gradientLayer.frame = view.bounds
        
         gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor.G1?.cgColor as Any
         ]
        
         view.layer.insertSublayer(gradientLayer, at : 0)
    }
}
