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

    
    var isAllDetailsPresent : Bool? = true


    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        let userSelectionTapGesture  = UITapGestureRecognizer(target: self, action:#selector(handleuserSelectionTapGesture))
        userSelectedLabel.addGestureRecognizer(userSelectionTapGesture)

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
    
    func handleuserSelectionTapGesture() {
        let actionSheet = UIAlertController.init(title:nil, message:nil, preferredStyle: .actionSheet)
        
        let brokerButton = UIAlertAction.init(title: "Broker", style: .default, handler: { (UIAlertAction) in
            self.userSelectedLabel.text = "Broker"
        })
        brokerButton.setValue(ColorConstants.red, forKey: "titleTextColor")
        brokerButton.setValue(ColorConstants.red, forKey:"imageTintColor")
        
        let brokerageButton = UIAlertAction.init(title: "Brokerage Firm", style: .default, handler: { (UIAlertAction) in
            self.userSelectedLabel.text = "Brokerage Firm"
        })
        brokerageButton.setValue( ColorConstants.red
            , forKey: "titleTextColor")
        brokerageButton.setValue(ColorConstants.red, forKey:"imageTintColor")
        
        
        let cancelButton = UIAlertAction.init(title: "Cancel", style: .default, handler: { (UIAlertAction) in
            actionSheet.dismiss(animated: true, completion: nil)
        })
        cancelButton.setValue( ColorConstants.red, forKey: "titleTextColor")
        
        
        if (userSelectedLabel.text == "Broker") {
            brokerButton.setValue(true, forKey: "checked")
        }
        else{
            brokerageButton.setValue(true, forKey: "checked")
            
        }
        
        actionSheet.addAction(brokerButton)
        actionSheet.addAction(brokerageButton)
        actionSheet.addAction(cancelButton)
        
        
    }

    
 //Mark:- Keyboard hide and show
    
    func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero;
        scrollView.contentInset = contentInset
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
//        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
//        scrollView.contentInset = contentInset
//        scrollView.contentOffset = CGPoint(x: 0, y: -60)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.contentOffset = CGPoint(x: 0, y: -60)
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
