//
//  MCALoginViewController.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import SwiftyJSON
class MCALoginViewController: MCABaseViewController,UITextFieldDelegate,UIActionSheetDelegate {

    
    //MARK: - Attributes -

    @IBOutlet weak var emailIDOverLayView : MCARoundedOverlayView!
    @IBOutlet weak var passwordOverLayView : MCARoundedOverlayView!
    @IBOutlet weak var brokerSelectionSwitch: UISegmentedControl!
    @IBOutlet weak var emailIDTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var rememberPasswordBtn : UIButton!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var userSelectedLabel : UILabel!
    @IBOutlet weak var dropDownButton : UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var overlayViewConstraint: NSLayoutConstraint!
    
    var isBrokerLogin:Bool! = true
    //MARK: - View Life Cycle -
    
    @IBAction func changeBrokerSelection(_ sender: Any)
    {
        isBrokerLogin = !isBrokerLogin // Negate the broker selection switch to enable Broker / Brokerage Login
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailIDTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        loginButton.layer.cornerRadius = loginButton.frame.height/2
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true;
        rememberPasswordBtn.isSelected = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
//MARK: - Action Methods  -
    
    @IBAction func loginButtonPressed(sender:AnyObject){
        
        if ((emailIDTextField.text?.isEmpty)!) {
            let alertViewController = UIAlertController(title : "Alert", message : "Please Enter Email Id", preferredStyle : .alert)
            alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
            present(alertViewController, animated: true , completion: nil)
        
        }
        else{
            if !(MCAUtilities.isValidEmail(inEmailId: emailIDTextField.text!)) {
                let alertViewController = UIAlertController(title : "Alert", message : "Please Enter Valid  Email Id", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                present(alertViewController, animated: true , completion: nil)
            }
                    
        }
        if ((passwordTextField.text?.isEmpty)!) {
            let alertViewController = UIAlertController(title : "Alert", message : "Please Enter Password", preferredStyle : .alert)
            alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
            present(alertViewController, animated: true , completion: nil)
        }
        else
        {
            if true == isBrokerLogin {
                self.loginBroker()
            }
            else {
                self.loginBrokerage()
            }
        }
    }
    
    @IBAction func forgotPasswordButtonPressed (sender : AnyObject){
        let forgotPasswordStoryBoard = UIStoryboard(name : "ForgotPassword",
                                                    bundle : nil)
        let forgotPassword = forgotPasswordStoryBoard.instantiateViewController(withIdentifier: "ForgotPassword") as! MCAForgotPasswordVC
        self.navigationController?.pushViewController(forgotPassword,
                                                      animated: true)
    }
    
    @IBAction func newUserButtonPressed (sender : AnyObject){
        let registrationStoryBoard = UIStoryboard(name : "Registration",
                                                  bundle : nil)
        let registration = registrationStoryBoard.instantiateViewController(withIdentifier: "Registration") as! MCARegistrationVC
        
        self.navigationController?.pushViewController(registration,
                                                      animated: true)
    }
    
    @IBAction func aboutUSButtonPressed (sender : AnyObject){
        let WebViewStoryBoard = UIStoryboard(name : "WebView", bundle : nil)
        let aboutUs  = WebViewStoryBoard.instantiateViewController(withIdentifier: "WebView") as! MCAWebViewController
        aboutUs.nameTitle = NSLocalizedString("About Us", comment: "");
        
        self.navigationController?.pushViewController(aboutUs, animated: true)
    }
    
    @IBAction func termsAndConditionButtonPressed (sender : AnyObject){
        let WebViewStoryBoard = UIStoryboard(name : "WebView", bundle : nil)
        let termsAndCondition  = WebViewStoryBoard.instantiateViewController(withIdentifier: "WebView") as! MCAWebViewController
        termsAndCondition.nameTitle = NSLocalizedString("Terms & Conditions", comment: "")
        self.navigationController?.pushViewController(termsAndCondition, animated: true)
    }
    
    @IBAction func privacyButtonPressed (sender : AnyObject){
        let WebViewStoryBoard = UIStoryboard(name : "WebView", bundle : nil)
        let privacy  = WebViewStoryBoard.instantiateViewController(withIdentifier: "WebView") as! MCAWebViewController
        privacy.nameTitle = NSLocalizedString("Privacy Policy", comment: "")
        self.navigationController?.pushViewController(privacy, animated: true)
    }
    
    @IBAction func rememberBtn_box(sender: UIButton) {
        if (rememberPasswordBtn.isSelected == true) {
            rememberPasswordBtn.setImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
            rememberPasswordBtn.isSelected = false;
        }
        else {
            rememberPasswordBtn.setImage(UIImage(named: "icon_checked"), for: UIControlState.normal)
            
            rememberPasswordBtn.isSelected = true;
        }
    }
    

//MARK: - UITextField Methods -

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return true;
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         if(textField.tag == 1) {
                self.overlayViewConstraint.constant = -25;
                UIView.animate(withDuration: 0.5, animations:
                    {
                        self.view.layoutIfNeeded()
                })
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.overlayViewConstraint.constant = 18;
        UIView.animate(withDuration: 0.5, animations:
            {
                self.view.layoutIfNeeded()
        })
    }
    
    
    
    
    //MARK: - Login Methods -

    
    func loginBroker() {
        
        self.showActivityIndicator()
        var paramDict  = Dictionary<String, String>()
        paramDict["email"] = emailIDTextField.text
        paramDict["password"] = passwordTextField.text
        
        MCAWebServiceManager.sharedWebServiceManager.loginRequest(requestParam:paramDict,
                                                                 endPoint:MCAAPIEndPoints.BrokerLoginAPIEndPoint
            , successCallBack:{ (response : JSON!) in
                
                self.stopActivityIndicator()
                print("Success \(response)")
                
                
                let alertViewController = UIAlertController(title : "MCAP", message : "Login Success!", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    MCASessionManager.sharedSessionManager.mcapUser = MCAUser(loginUserData:response, userLoginType: 1) // Need to replace '0' with Enum
                    let mPinStoryBoard = UIStoryboard(name : "mPin", bundle : nil)
                    let mPin = mPinStoryBoard.instantiateViewController(withIdentifier: "MCAEnterMPinVC") as! MCAEnterMPinVC
                    self.navigationController?.pushViewController(mPin, animated: true)
                    
                    
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
    
    
    func loginBrokerage() {
        
        self.showActivityIndicator()
        
        var paramDict = Dictionary<String, String>()
        paramDict["email"] = emailIDTextField.text
        paramDict["password"] = passwordTextField.text
        
        
        MCAWebServiceManager.sharedWebServiceManager.loginRequest(requestParam:paramDict,
                                                                 endPoint:MCAAPIEndPoints.BrokerageLoginAPIEndPoint
            , successCallBack:{ (response : JSON!) in
                
                self.stopActivityIndicator()
                print("Success \(response)")
                
                let alertViewController = UIAlertController(title : "MCAP", message : "Login Success!", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    MCASessionManager.sharedSessionManager.mcapUser = MCAUser(loginUserData:response, userLoginType: 1) // Need to replace '0' with Enum
                    let mPinStoryBoard = UIStoryboard(name : "mPin", bundle : nil)
                    let mPin = mPinStoryBoard.instantiateViewController(withIdentifier: "MCAEnterMPinVC") as! MCAEnterMPinVC
                    self.navigationController?.pushViewController(mPin, animated: true)
                    
                    
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
