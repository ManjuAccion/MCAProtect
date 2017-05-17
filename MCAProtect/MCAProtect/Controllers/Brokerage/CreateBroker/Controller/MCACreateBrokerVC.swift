//
//  MCACreateBrokerVC.swift
//  MCAProtect
//
//  Created by Sarath Neeravallil on 16/05/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCACreateBrokerVC: MCABaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var brokerNameTF     : UITextField!
    @IBOutlet weak var emailTF          : UITextField!
    @IBOutlet weak var telephoneTF      : UITextField!
    @IBOutlet weak var passwordTF       : UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var submitButton     : UIButton!
    @IBOutlet weak var topConstraint    : NSLayoutConstraint!
    
    var inputTextField      : UITextField!
    var toolbar             : UIToolbar?
    var doneButton          : UIBarButtonItem?
    var keyBoardHeight      : CGFloat!
    var isAllDetailsPresent : Bool? = true

    let textfieldHeight     : CGFloat = 35
    let toolBarHeight       : CGFloat = 44

    //MARK: - View Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Broker"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        self.hideKeyboardWhenTappedAround()
        submitButton.layer.cornerRadius = submitButton.frame.size.height / 2
        initilazeToolBar()
        isAllDetailsPresent = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - IBAction Methods -
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        performTextFiledValidations()
        
        if isAllDetailsPresent != nil && isAllDetailsPresent == true {
            createBroker()
        }
    }
    
    
    //MARK: - UIToolBar Methods -
    
    func initilazeToolBar() {
        
        toolbar = UIToolbar()
        toolbar?.isTranslucent = false
        toolbar?.barTintColor = UIColor.darkGray
        toolbar?.sizeToFit()
        
        doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(inputToolbarDonePressed))
        doneButton?.tintColor = .white
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar?.setItems([flexibleSpaceButton, doneButton!], animated: false)
        toolbar?.isUserInteractionEnabled = true
    }

    func inputToolbarDonePressed() {
        
        switch inputTextField {
            
            case brokerNameTF   :   inputTextField.resignFirstResponder()
                                    emailTF.becomeFirstResponder()
            case emailTF        :   inputTextField.resignFirstResponder()
                                    telephoneTF.becomeFirstResponder()
            case telephoneTF    :   inputTextField.resignFirstResponder()
                                    passwordTF.becomeFirstResponder()
            case passwordTF     :   inputTextField.resignFirstResponder()
                                    confirmPasswordTF.becomeFirstResponder()
            case confirmPasswordTF: inputTextField.resignFirstResponder()
                
            default:break
        }
    }
    
    //MARK: - Keyboard Delegate Methods -

    
    func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        keyBoardHeight = keyboardFrame.size.height
    }
    
    //MARK: - UITextField Delegate Methods -
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        inputTextField = textField
        inputTextField?.inputAccessoryView = toolbar
        
        if(textField == confirmPasswordTF) {
            
            if !((ceil((textField.superview?.frame.origin.y)!) + textfieldHeight) <= (self.view.frame.size.height - (keyBoardHeight + toolBarHeight))) {
                topConstraint.constant = -20
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
        topConstraint.constant = 20
        UIView.animate(withDuration: 0.5, animations:
            {
                self.view.layoutIfNeeded()
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
            case brokerNameTF       :   textField.resignFirstResponder()
                                        emailTF.becomeFirstResponder()
            case emailTF            :   textField.resignFirstResponder()
                                        telephoneTF.becomeFirstResponder()
            case telephoneTF        :   textField.resignFirstResponder()
                                        passwordTF.becomeFirstResponder()
            case passwordTF         :   textField.resignFirstResponder()
                                        confirmPasswordTF.becomeFirstResponder()
            case confirmPasswordTF  :   textField.resignFirstResponder()
                
            default                 :   break
            
        }
        
        return true
    }
    
    func performTextFiledValidations() {
        
        if ((brokerNameTF.text?.isEmpty)!) {
            
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Please Enter Broker Name", comment: ""))
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
        else if ((telephoneTF.text?.isEmpty)!)
        {
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Please Enter Phone Number", comment: ""))
            isAllDetailsPresent = false
        }
        else if ((telephoneTF.text?.characters.count)! != 10)
        {
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Please Enter Valid Phone Number", comment: ""))
            isAllDetailsPresent = false
        }

        else if ((passwordTF.text?.isEmpty)!) {
            
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Please Enter Password", comment: ""))
            isAllDetailsPresent = false
        }
        else if ((passwordTF.text?.characters.count)! < 5) {
            
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Password requires minimum 5 characters", comment: ""))
            isAllDetailsPresent = false
        }
        else if ((confirmPasswordTF.text?.isEmpty)!) {
            
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Please Enter Confirm Password", comment: ""))
            isAllDetailsPresent = false
        }
        else if ((confirmPasswordTF.text?.characters.count)! < 5) {
            
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Confirm Password requires minimum 5 characters", comment: ""))
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
    }
    
    //MARK: - API Call
    
    func createBroker() {
        
        if self.checkNetworkConnection() == false {
            return
        }
        
        self.showActivityIndicator()

        var paramDict = Dictionary<String, String>()
        
        paramDict["confirm_success_url"]    = " "
        paramDict["contact_name"]           = brokerNameTF.text
        paramDict["email"]                  = emailTF.text
        paramDict["contact_number"]         = telephoneTF.text
        paramDict["password"]               = passwordTF.text
        paramDict["password_confirmation"]  = confirmPasswordTF.text
        paramDict["image_url"]              = ""

        
        MCAWebServiceManager.sharedWebServiceManager.postRequest(requestParam:paramDict,
                                                                 endPoint:MCAAPIEndPoints.BrokerageCreateBrokerAPIEndPoint
            , successCallBack:{ (response : JSON!) in
                
                self.stopActivityIndicator()
                print("Success \(response)")
                
                let alertViewController = UIAlertController(title : "MCAP", message : response["status"].stringValue, preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    self.navigationController?.popViewController(animated: true)

                }))
                self.present(alertViewController, animated: true , completion: nil)
                
        },
              failureCallBack: { (error : Error) in
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Unable to create Broker", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
    }
}
