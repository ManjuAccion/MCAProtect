//
//  MCAForgotPasswordVC.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAForgotPasswordVC: MCABaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var forgotPasswordLabel : UILabel!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var overlayViewConstraint: NSLayoutConstraint!

    var isAllDetailsPresent : Bool? = true

    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forgot Password"
        self.navigationController?.navigationBar.isHidden = false;
        isAllDetailsPresent = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UITextField Delegate Methods

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if(textField.tag == 1){
            
            self.overlayViewConstraint.constant = 0;
            UIView.animate(withDuration: 0.5, animations:
                {
                    self.view.layoutIfNeeded()
            })
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        self.overlayViewConstraint.constant = 64;
        UIView.animate(withDuration: 0.5, animations:
            {
                self.view.layoutIfNeeded()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    //MARK: - Action Methods
    
    @IBAction func resetPasswordPressed (sender : AnyObject){
        if (emailTextField.text?.isEmpty)! {
            let alertViewController = UIAlertController(title : "Alert", message : "Please Enter Email ID", preferredStyle : .alert)
            alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
            present(alertViewController, animated: true , completion: nil)
            isAllDetailsPresent = false
        }
        else
        {
            if !(MCAUtilities.isValidEmail(inEmailId: emailTextField.text!)) {
                let alertViewController = UIAlertController(title : "Alert", message : "Please Enter valid Email", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                present(alertViewController, animated: true , completion: nil)
                isAllDetailsPresent = false
            }
            else
            {
                isAllDetailsPresent = true
            }
        }
        
        if isAllDetailsPresent != nil && isAllDetailsPresent == true {

            self.forgotPassword()
        }
    }
    
    
    func forgotPassword() {
        
        self.showActivityIndicator()
        
        var paramDict = Dictionary<String, String>()
        paramDict["email"] = emailTextField.text
        paramDict["redirect_url"] = "https://broker-dev.mcaprotect.org/"

        
//        https://broker-dev.mcaprotect.org/
        
        MCAWebServiceManager.sharedWebServiceManager.postRequest(requestParam:paramDict,
                                                                 endPoint:MCAAPIEndPoints.BrokerForgotPasswordAPIEndPoint
            , successCallBack:{ (response : JSON!) in
                
                self.stopActivityIndicator()
                print("Success \(response)")
                
                
                let alertViewController = UIAlertController(title : "MCAP", message : response["message"].stringValue, preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    self.navigationController?.popViewController(animated: true)

                    
                }))
                self.present(alertViewController, animated: true , completion: nil)
                
        },
              failureCallBack: { (error : Error) in
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Login Failed", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
    }
    
    
    
}
