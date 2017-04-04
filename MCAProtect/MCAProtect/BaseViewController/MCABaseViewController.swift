//
//  MCABaseViewController.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import MessageUI

class MCABaseViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    var activityView:UIView!
    var activityIndicatorCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        print("---Controller====>//",self.description)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        self.view.setNeedsLayout();
    }


    @IBAction func backButtonPressed (_ : Any)
    {
        self.navigationController?.popViewController(animated: true);
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public func emailButtonTapped()
    {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["halen@MCAProtect.com"])
                mail.setMessageBody("", isHTML: true)
                
                present(mail, animated: true)
            } else {
                // show failure alert
            }
        }
        
        func mailComposeController(_ controller:MFMailComposeViewController , didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
    }
    
    public func callButtonTapped()
    {
        let alertViewController = UIAlertController(title : "", message : "447415554422", preferredStyle : .alert)
        alertViewController.view.tintColor = ColorConstants.red
        alertViewController.addAction(UIAlertAction(title : "Cancel" , style : .default , handler : nil))
        
        alertViewController.addAction(UIAlertAction(title : "Call" , style : .default , handler : { action in
            
            if let url = NSURL(string: "tel://447415554422"), UIApplication.shared.canOpenURL(url as URL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open((url as URL),  options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url as URL)
                }
            }
            
        }))

        present(alertViewController, animated: true , completion: nil)

    }
    
    
    public func showActivityIndicator()
    {
        activityIndicatorCount = activityIndicatorCount + 1
        if activityIndicatorCount > 1 {
            return;
        }
        
        UIApplication.shared.keyWindow?.viewWithTag(987)?.removeFromSuperview()
        self.view.layoutIfNeeded();
        
        if  nil == activityView {
            activityView = UIView(frame: self.view.bounds)
            activityView.tag = 987;
            activityView.backgroundColor = UIColor.clear
            activityView.alpha = 0.0
            let bgView = UIView(frame: activityView.bounds)
            bgView.alpha = 0.0
            bgView.backgroundColor = UIColor.gray
            activityView.addSubview(bgView)
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityView.addSubview(spinner)
            spinner.center = self.view.center
            spinner.color = UIColor.white
            spinner.startAnimating()
            
            UIView.animate(withDuration: 0.2, animations: {
                    bgView.alpha = 0.5;
                    self.activityView.alpha = 1.0;

            })
        }
        else
        {
            UIView.animate(withDuration: 0.2, animations: {
                self.activityView.alpha = 1.0;
                
            })
        }
        
        UIApplication.shared.keyWindow?.addSubview(activityView)
        
    }

    
    public func stopActivityIndicator()
    {
        activityIndicatorCount = activityIndicatorCount - 1
        if activityIndicatorCount <= 0
        {
            activityIndicatorCount = 0;
            UIView.animate(withDuration: 0.2, animations: {
                self.activityView.alpha = 0.0;
            }, completion: { (true: Bool) in
                self.activityView.removeFromSuperview()
            })
        }
    }

    
}
