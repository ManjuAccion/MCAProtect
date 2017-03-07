//
//  MCALoginViewController.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class MCALoginViewController: MCABaseViewController,UITextFieldDelegate,UIActionSheetDelegate {
    
    @IBOutlet weak var emailIDTextField : JVFloatLabeledTextField!
    @IBOutlet weak var passwordTextField : JVFloatLabeledTextField!
    @IBOutlet weak var rememberPasswordBtn : UIButton!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var userSelectedLabel : UILabel!
    @IBOutlet weak var dropDownButton : UIButton!
    
    @IBOutlet weak var overlayViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
//            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
            let userSelectionTapGesture  = UITapGestureRecognizer(target: self, action:#selector(handleuserSelectionTapGesture))
            userSelectedLabel.addGestureRecognizer(userSelectionTapGesture)
    
            emailIDTextField.autocorrectionType = UITextAutocorrectionType.no
            passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true;
        rememberPasswordBtn.setBackgroundImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
        rememberPasswordBtn.isSelected = false


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


        present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

    //Mark:- Keyboard hide and show
    
//    func keyboardWillShow(notification:NSNotification){
//        var userInfo = notification.userInfo!
//        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
//        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
//        
//        var contentInset:UIEdgeInsets = scrollView.contentInset
//        contentInset.bottom = keyboardFrame.size.height
//        scrollView.contentInset = contentInset
//    }
//    
//    func keyboardWillHide(notification:NSNotification){
//        let contentInset:UIEdgeInsets = UIEdgeInsets.zero;
//        scrollView.contentInset = contentInset
//    }
//
    
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
            let mPinStoryBoard = UIStoryboard(name : "mPin", bundle : nil)
            let mPin = mPinStoryBoard.instantiateViewController(withIdentifier: "MCAEnterMPinVC") as! MCAEnterMPinVC
            self.navigationController?.pushViewController(mPin, animated: true)
            
        }
        
    }
    
    @IBAction func forgotPasswordButtonPressed (sender : AnyObject){
        let forgotPasswordStoryBoard = UIStoryboard(name : "ForgotPassword", bundle : nil)
        let forgotPassword = forgotPasswordStoryBoard.instantiateViewController(withIdentifier: "ForgotPassword") as! MCAForgotPasswordVC
        self.navigationController?.pushViewController(forgotPassword, animated: true)

        
    }
    
    @IBAction func newUserButtonPressed (sender : AnyObject){
        let registrationStoryBoard = UIStoryboard(name : "Registration", bundle : nil)
        let registration = registrationStoryBoard.instantiateViewController(withIdentifier: "Registration") as! MCARegistrationVC
        
        self.navigationController?.pushViewController(registration, animated: true)
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true);
        return true;
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
     if(textField.tag == 1){
        
        self.overlayViewConstraint.constant = -25;
        UIView.animate(withDuration: 0.5, animations:
            {
                self.view.layoutIfNeeded()
        })
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        self.overlayViewConstraint.constant = 18;
        UIView.animate(withDuration: 0.5, animations:
            {
                self.view.layoutIfNeeded()
        })
    }
    
    
    @IBAction func rememberBtn_box(sender: UIButton) {
        if (rememberPasswordBtn.isSelected == true)
        {
            rememberPasswordBtn.setBackgroundImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
                      rememberPasswordBtn.isSelected = false;
        }
        else
        {
            rememberPasswordBtn.setBackgroundImage(UIImage(named: "icon_checked"), for: UIControlState.normal)
            
            rememberPasswordBtn.isSelected = true;
        }
    }

}
