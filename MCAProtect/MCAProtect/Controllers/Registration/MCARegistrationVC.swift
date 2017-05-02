//
//  MCARegistrationVC.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCARegistrationVC: MCABaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var businessNameTF : UITextField!
    @IBOutlet weak var emailTF : UITextField!
    @IBOutlet weak var phoneNumberTF : UITextField!
    @IBOutlet weak var passwordTF : UITextField!
    @IBOutlet weak var confirmPasswordTF : UITextField!
    @IBOutlet weak var userSelectedLabel : UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    var toolbar : UIToolbar?
    let textfieldHeight : CGFloat = 35
    let toolBarHeight : CGFloat = 44

    
    @IBOutlet weak var topSpaceConstraints: NSLayoutConstraint!
    var isAllDetailsPresent : Bool? = true
    var keyBoardHeight : CGFloat!
    var doneButton : UIBarButtonItem?
    var inputTextField : UITextField!



    override func viewDidLoad() {
        super.viewDidLoad()
        keyBoardHeight = 216
        self.title = "Brokerage Firm Registration"
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        signUpButton.layer.cornerRadius = signUpButton.frame.height/2
        initilazeToolBar()

        self.navigationController?.navigationBar.isHidden = false

        isAllDetailsPresent = true
           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initilazeToolBar() {
        toolbar = UIToolbar()
        toolbar?.isTranslucent = false
        toolbar?.barTintColor = UIColor.darkGray
        toolbar?.sizeToFit()
        
        doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.inputToolbarDonePressed))
        doneButton?.tintColor = .white
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar?.setItems([flexibleSpaceButton, doneButton!], animated: false)
        toolbar?.isUserInteractionEnabled = true
        
    }
    
    func inputToolbarDonePressed() {
//        inputTextField.resignFirstResponder()
        switch inputTextField {
            case businessNameTF : inputTextField.resignFirstResponder()
                                  emailTF.becomeFirstResponder()
            case emailTF        : inputTextField.resignFirstResponder()
                                  phoneNumberTF.becomeFirstResponder()
            case phoneNumberTF  : inputTextField.resignFirstResponder()
                                  passwordTF.becomeFirstResponder()
            case passwordTF     : inputTextField.resignFirstResponder()
                                  confirmPasswordTF.becomeFirstResponder()
            case confirmPasswordTF: inputTextField.resignFirstResponder()
                
            default:
                break
        }
    }
    
 //Mark:- Keyboard hide and show
    
    func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
       keyBoardHeight = keyboardFrame.size.height
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        inputTextField = textField
        inputTextField?.inputAccessoryView = toolbar

        if textField.tag < 2 {
            UIView.animate(withDuration: 0.5, animations:
                {
                    self.view.layoutIfNeeded()
            })
        }
       
        if(textField.tag == 3 || textField.tag == 2 ) {
            if !( (ceil((textField.superview?.frame.origin.y)!) + textfieldHeight)  <= (self.view.frame.size.height - (keyBoardHeight + toolBarHeight)))
            {
                self.topSpaceConstraints.constant = -15;
                UIView.animate(withDuration: 0.5, animations:
                    {
                        self.view.layoutIfNeeded()
                })
            }
        }

        if(textField.tag == 4) {
             if !((ceil((textField.superview?.frame.origin.y)!) + textfieldHeight) <= (self.view.frame.size.height - (keyBoardHeight + toolBarHeight))) {
                    self.topSpaceConstraints.constant = -64;
                    UIView.animate(withDuration: 0.5, animations:
                        {
                            self.view.layoutIfNeeded()
                    })
                }
        }
        if textField == confirmPasswordTF {
            doneButton?.title = "Done"
        }
        else {
            doneButton?.title = "Next"
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.topSpaceConstraints.constant = 64;
        UIView.animate(withDuration: 0.5, animations:
            {
                self.view.layoutIfNeeded()
        })
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            case businessNameTF : textField.resignFirstResponder()
                                  emailTF.becomeFirstResponder()
            case emailTF        : textField.resignFirstResponder()
                                  phoneNumberTF.becomeFirstResponder()
            case phoneNumberTF  : textField.resignFirstResponder()
                                  passwordTF.becomeFirstResponder()
            case passwordTF     : textField.resignFirstResponder()
                                  confirmPasswordTF.becomeFirstResponder()
            case confirmPasswordTF: textField.resignFirstResponder()
        
            default:
                break
        }
        
        return true
    }
    
    
    
    @IBAction func registerButtonPressed (sender : AnyObject){
        
        self.view.endEditing(true)
            
        if ((businessNameTF.text?.isEmpty)!) {
            
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Please Enter Business Name", comment: ""))
            isAllDetailsPresent = false
        }
        else if ((emailTF.text?.isEmpty)!) {
            
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Please Enter Email", comment: ""))
            isAllDetailsPresent = false
        }
        else if !(MCAUtilities.isValidEmail(inEmailId: emailTF.text!)) {
            
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Please Enter Valid  Email Id", comment: ""))
            isAllDetailsPresent = false
        }
        else if ((phoneNumberTF.text?.isEmpty)!)
        {
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Please Enter Phone Number", comment: ""))
            isAllDetailsPresent = false
        }
        else if ((passwordTF.text?.isEmpty)!) {
            
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Please Enter Password", comment: ""))
            isAllDetailsPresent = false
        }
        else if ((confirmPasswordTF.text?.isEmpty)!) {
            
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Please Enter Confirm Password", comment: ""))
            isAllDetailsPresent = false
        }
        else if (!(confirmPasswordTF.text?.isEmpty)! && !(passwordTF.text?.isEmpty)!  )
        {
            if (confirmPasswordTF.text == passwordTF.text) {
                isAllDetailsPresent = true
            }
            else {
                
                presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Passwords Do Not Match", comment: ""))
                isAllDetailsPresent = false
            }
        }
        else {
            isAllDetailsPresent = true
        }
            
        if isAllDetailsPresent != nil && isAllDetailsPresent == true {
            self.RegisterBrokerage()
            
        }
}
    
    func RegisterBrokerage() {
        
        if self.checkNetworkConnection() == false {
            return
        }
    
        self.showActivityIndicator()

        
        var paramDict = Dictionary<String, String>()
        
        paramDict["business_name"] = businessNameTF.text
        paramDict["email"] = emailTF.text
        paramDict["contact_number"] = phoneNumberTF.text
        paramDict["password"] = passwordTF.text
        paramDict["password_confirmation"] = confirmPasswordTF.text
        
        
        MCAWebServiceManager.sharedWebServiceManager.postRequest(requestParam:paramDict,
                                                                 endPoint:MCAAPIEndPoints.BrokerageRegistrationAPIEndPoint
            , successCallBack:{ (response : JSON!) in
                self.stopActivityIndicator()
                print("Success \(response)")
                
                let alertViewController = UIAlertController(title : "MCAP", message : "Registration Successful", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : { action in
                    
                    let storyboard = UIStoryboard(name: "mPin", bundle: nil)
                    let setPinVC = storyboard.instantiateViewController(withIdentifier: "MCASetMPinVC") as! MCASetMPinVC
                    setPinVC.isFromRegistrationFlow = true
                    self.navigationController?.pushViewController(setPinVC,
                                                                  animated: true)
                    
                    
                }))
                
                
                self.present(alertViewController, animated: true , completion: nil)

                
        }, failureCallBack: { (error : Error) in
            self.stopActivityIndicator()
            print("Failure \(error)")
            let alertViewController = UIAlertController(title : "MCAP", message : "Registration Failed", preferredStyle : .alert)
            alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
            self.present(alertViewController, animated: true , completion: nil)
            
        })
    }
    
    
    
   
}
