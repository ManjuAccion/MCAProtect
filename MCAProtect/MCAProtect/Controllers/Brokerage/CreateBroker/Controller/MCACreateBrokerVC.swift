//
//  MCACreateBrokerVC.swift
//  MCAProtect
//
//  Created by Sarath Neeravallil on 16/05/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

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
            presentAlertWithTitle(title: "Alert", message: NSLocalizedString("Please Enter Telephone", comment: ""))
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
    }
    
    //MARK: - API Call
    
    func createBroker() {
        print("Need to implement api")
    }

}

/*
    1: Set the proper keyboards for text fields
    2: Add tool bar with next and done button
    3: Scroll the confirm pwd based on the keyboard
    4: Rounded corner for submit button
    5: Set the dot for pwd and confirm pwd
    6: Need to do the validations for email anf mobile number and pwd
    7: Need to show the proper error alert msgs
    8: Check the internet connectivity
    9: Need to call the api 
   10: Add navigation for back and submit button
 
 */
