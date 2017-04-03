//
//  MCARegistrationVC.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

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
//       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        initilazeToolBar()


        self.navigationController?.navigationBar.isHidden = false
//        businessNameTF.autocorrectionType = UITextAutocorrectionType.no
//        emailTF.autocorrectionType = UITextAutocorrectionType.no
//        phoneNumberTF.autocorrectionType = UITextAutocorrectionType.no
//        passwordTF.autocorrectionType = UITextAutocorrectionType.no
//        confirmPasswordTF.autocorrectionType = UITextAutocorrectionType.no

        isAllDetailsPresent = true
           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initilazeToolBar() {
        toolbar = UIToolbar()
        toolbar?.barStyle = .blackTranslucent
        toolbar?.isTranslucent = true
        toolbar?.sizeToFit()
        
        doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.inputToolbarDonePressed))
        doneButton?.tintColor = .white
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar?.setItems([flexibleSpaceButton, doneButton!], animated: false)
        toolbar?.isUserInteractionEnabled = true
        
    }
    
    func inputToolbarDonePressed() {
        inputTextField.resignFirstResponder()
    }


    
 //Mark:- Keyboard hide and show
    
    func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
       keyBoardHeight = keyboardFrame.size.height
    }
//
//    func keyboardWillHide(notification:NSNotification){
////        scrollView.contentOffset = CGPoint(x: 0, y: -60)
//
//    }
//
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        inputTextField = textField
        inputTextField?.inputAccessoryView = toolbar

        if textField.tag < 2 {
            UIView.animate(withDuration: 0.5, animations:
                {
                    self.view.layoutIfNeeded()
            })
 
        }
        
        
       
        if(textField.tag == 3 || textField.tag == 2 )
{
            if !( (ceil((textField.superview?.frame.origin.y)!) + textfieldHeight)  <= (self.view.frame.size.height - (keyBoardHeight + toolBarHeight)))
            {
                self.topSpaceConstraints.constant = -15;
                UIView.animate(withDuration: 0.5, animations:
                    {
                        self.view.layoutIfNeeded()
                })
            }
        }
        

        if(textField.tag == 4)
        {
         if !((ceil((textField.superview?.frame.origin.y)!) + textfieldHeight) <= (self.view.frame.size.height - (keyBoardHeight + toolBarHeight)))
            {
                self.topSpaceConstraints.constant = -64;
                UIView.animate(withDuration: 0.5, animations:
                    {
                        self.view.layoutIfNeeded()
                })

            }
              }
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        self.topSpaceConstraints.constant = 64;
        UIView.animate(withDuration: 0.5, animations:
            {
                self.view.layoutIfNeeded()
        })
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    
    @IBAction func registerButtonPressed (sender : AnyObject){
        
    self.view.endEditing(true)
        
    if ((businessNameTF.text?.isEmpty)!) {
        
        let alertViewController = UIAlertController(title : "Alert", message : NSLocalizedString("Please Enter Business Name", comment: ""), preferredStyle : .alert)
        alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
        present(alertViewController, animated: true , completion: nil)
        isAllDetailsPresent = false
        
    }
        else
    {
        isAllDetailsPresent = true

        }
    if ((emailTF.text?.isEmpty)!) {
            
        let alertViewController = UIAlertController(title : "Alert", message : NSLocalizedString("Please Enter Email", comment: "") , preferredStyle : .alert)
        alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
        present(alertViewController, animated: true , completion: nil)
        isAllDetailsPresent = false
    }
    else {
        if !(MCAUtilities.isValidEmail(inEmailId: emailTF.text!)) {
            let alertViewController = UIAlertController(title : "Alert", message : "Please Enter Valid  Email Id", preferredStyle : .alert)
            alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
            present(alertViewController, animated: true , completion: nil)
            isAllDetailsPresent = false
        }
        else{
            
            isAllDetailsPresent = true

        }
    }

    if ((phoneNumberTF.text?.isEmpty)!)
    {
        
        let alertViewController = UIAlertController(title : "Alert", message :NSLocalizedString("Please Enter Phone Number", comment: ""), preferredStyle : .alert)
        alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
        present(alertViewController, animated: true , completion: nil)
        isAllDetailsPresent = false
    }
        else
    {
        
        isAllDetailsPresent = true

        }
    if ((passwordTF.text?.isEmpty)!)
    {
        
        let alertViewController = UIAlertController(title : "Alert", message : NSLocalizedString("Please Enter Confirm Password", comment: "") , preferredStyle : .alert)
        alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
        present(alertViewController, animated: true , completion: nil)
        isAllDetailsPresent = false
    }
    else{
        
        isAllDetailsPresent = true

        }
    if ((confirmPasswordTF.text?.isEmpty)!)
    {
        let alertViewController = UIAlertController(title : "Alert", message : NSLocalizedString("Please Enter Confirm Password", comment:"") , preferredStyle : .alert)
        alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
        present(alertViewController, animated: true , completion: nil)
        isAllDetailsPresent = false
    }
        
    if (!(confirmPasswordTF.text?.isEmpty)! && !(passwordTF.text?.isEmpty)!  )
    {
        if (confirmPasswordTF.text == passwordTF.text) {
            isAllDetailsPresent = true
 
        }
        else{
            
            let alertViewController = UIAlertController(title : "Alert", message : NSLocalizedString("Passwords Do Not Match", comment : "")  , preferredStyle : .alert)
            alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
            present(alertViewController, animated: true , completion: nil)
            isAllDetailsPresent = false
        }
    }
        
    if isAllDetailsPresent != nil && isAllDetailsPresent == true {
        
    }
        self.RegisterBrokerage()
    }

    
    
    func RegisterBrokerage() {
        
        self.showActivityIndicator()
        
        var paramDict = Dictionary<String, String>()
        
        paramDict["business_name"] = businessNameTF.text
        paramDict["email"] = emailTF.text
        paramDict["contact_number"] = phoneNumberTF.text
        paramDict["password"] = passwordTF.text
        paramDict["password_confirmation"] = confirmPasswordTF.text
        
        
        MCAWebServiceManager.sharedWebServiceManager.postRequest(requestParam:paramDict,
                                                                 endPoint:MCAAPIEndPoints.BrokerageRegistrationAPIEndPoint
            , successCallBack:{ (response : Dictionary<String, AnyObject>!) in
                self.stopActivityIndicator()
                print("Success \(response)")
                let storyboard = UIStoryboard(name: "mPin", bundle: nil)
                let setPinVC = storyboard.instantiateViewController(withIdentifier: "MCASetMPinVC") as! MCASetMPinVC
                setPinVC.isFromRegistrationFlow = true
                self.navigationController?.pushViewController(setPinVC,
                                                         animated: true)
        }, failureCallBack: { (error : Error) in
            self.stopActivityIndicator()
            print("Failure \(error)")
            let alertViewController = UIAlertController(title : "MCAP", message : "Registration Failed", preferredStyle : .alert)
            alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
            self.present(alertViewController, animated: true , completion: nil)
            
        })
    }
    
    
    
   
}
