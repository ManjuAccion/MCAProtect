//
//  UIViewController+Extensions.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public static var current: UIViewController? {
        if let controller = UIApplication.shared.keyWindow?.rootViewController {
            return findCurrent(controller)
        }
        return nil
    }
    
    private static func findCurrent(_ controller: UIViewController) -> UIViewController {
        if let controller = controller.presentedViewController {
            return findCurrent(controller)
        }
        else if let controller = controller as? UISplitViewController, let lastViewController = controller.viewControllers.first, controller.viewControllers.count > 0 {
            return findCurrent(lastViewController)
        }
        else if let controller = controller as? UINavigationController, let topViewController = controller.topViewController, controller.viewControllers.count > 0 {
            return findCurrent(topViewController)
        }
        else if let controller = controller as? UITabBarController, let selectedViewController = controller.selectedViewController, (controller.viewControllers?.count ?? 0) > 0 {
            return findCurrent(selectedViewController)
        }
        else {
            return controller
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func presentAlertWithTitle(title: String, message : String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in print("Youve pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
