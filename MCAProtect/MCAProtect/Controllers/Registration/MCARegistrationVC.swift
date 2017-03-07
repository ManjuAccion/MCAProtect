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
    @IBOutlet weak var businessNameTF : JVFloatLabeledTextField!
    @IBOutlet weak var emailTF : JVFloatLabeledTextField!
    @IBOutlet weak var phoneNumberTF : JVFloatLabeledTextField!
    @IBOutlet weak var passwordTF : JVFloatLabeledTextField!
    @IBOutlet weak var confirmPasswordTF : JVFloatLabeledTextField!
    @IBOutlet weak var userSelectedLabel : UILabel!

    
    @IBOutlet weak var topSpaceConstraints: NSLayoutConstraint!
    var isAllDetailsPresent : Bool? = true
    var keyBoardHeight : CGFloat!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Brokerage Firm Registration"
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
//       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)

        self.navigationController?.navigationBar.isHidden = false
        businessNameTF.autocorrectionType = UITextAutocorrectionType.no
        emailTF.autocorrectionType = UITextAutocorrectionType.no
        phoneNumberTF.autocorrectionType = UITextAutocorrectionType.no
        passwordTF.autocorrectionType = UITextAutocorrectionType.no
        confirmPasswordTF.autocorrectionType = UITextAutocorrectionType.no

        isAllDetailsPresent = true
           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
 //Mark:- Keyboard hide and show
    
//    func keyboardWillShow(notification:NSNotification){
//        var userInfo = notification.userInfo!
//        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
//        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
//        topSpaceConstraints.constant = topSpaceConstraints.constant - keyboardFrame.size.height
//       keyBoardHeight = keyboardFrame.size.height
//    }
//
//    func keyboardWillHide(notification:NSNotification){
////        scrollView.contentOffset = CGPoint(x: 0, y: -60)
//
//    }
//
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField.tag <= 2 {
            UIView.animate(withDuration: 0.5, animations:
                {
                    self.view.layoutIfNeeded()
            })
 
        }
       
        if(textField.tag == 3 || textField.tag == 2){
            
            self.topSpaceConstraints.constant = -5;
            UIView.animate(withDuration: 0.5, animations:
                {
                    self.view.layoutIfNeeded()
            })
        }

        if(textField.tag == 4)
        {
            self.topSpaceConstraints.constant = -25;
            UIView.animate(withDuration: 0.5, animations:
                {
                    self.view.layoutIfNeeded()
            })
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
//        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
//        scrollView.contentInset = contentInset
//        scrollView.contentOffset = CGPoint(x: 0, y: -60)
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
    }

    if ((phoneNumberTF.text?.isEmpty)!)
    {
        
        let alertViewController = UIAlertController(title : "Alert", message :NSLocalizedString("Please Enter Phone Number", comment: ""), preferredStyle : .alert)
        alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
        present(alertViewController, animated: true , completion: nil)
        isAllDetailsPresent = false
    }
    if ((passwordTF.text?.isEmpty)!)
    {
        
        let alertViewController = UIAlertController(title : "Alert", message : NSLocalizedString("Please Enter Confirm Password", comment: "") , preferredStyle : .alert)
        alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
        present(alertViewController, animated: true , completion: nil)
        isAllDetailsPresent = false
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
            
        }
        else{
            
            let alertViewController = UIAlertController(title : "Alert", message : NSLocalizedString("Passwords Do Not Match", comment : "")  , preferredStyle : .alert)
            alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
            present(alertViewController, animated: true , completion: nil)
            isAllDetailsPresent = false
        }
    }
        
    if isAllDetailsPresent != nil && isAllDetailsPresent == true {
        
        let storyboard = UIStoryboard(name: "mPin", bundle: nil)
        let setPinVC = storyboard.instantiateViewController(withIdentifier: "MCASetMPinVC") as! MCASetMPinVC
        setPinVC.isFromRegistrationFlow = true
        navigationController?.pushViewController(setPinVC,
                                                      animated: true)
    }

    }

   
}
