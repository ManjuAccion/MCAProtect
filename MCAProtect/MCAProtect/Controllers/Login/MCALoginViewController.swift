//
//  MCALoginViewController.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class MCALoginViewController: MCABaseViewController,UITextFieldDelegate {
    @IBOutlet weak var emailIDTextField : JVFloatLabeledTextField!
    @IBOutlet weak var passwordTextField : JVFloatLabeledTextField!
    @IBOutlet weak var rememberPasswordBtn : UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

    
    @IBAction func loginButtonPressed(sender:AnyObject){
        if ((emailIDTextField.text?.isEmpty)!) {
            let alertViewController = UIAlertController(title : "Alert", message : "Please Enter Email Id", preferredStyle : .alert)
            alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
            present(alertViewController, animated: true , completion: nil)
        
        }
        else{
            if !(MCAUtilities.isValidEmail(testStr: emailIDTextField.text!)) {
                let alertViewController = UIAlertController(title : "Alert", message : "Please Enter Valid  Email Id", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                present(alertViewController, animated: true , completion: nil)
            }
                    
        }
        if (passwordTextField.text?.isEmpty)! {
            let alertViewController = UIAlertController(title : "Alert", message : "Please Enter Password", preferredStyle : .alert)
            alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
            present(alertViewController, animated: true , completion: nil)
        }
        else{
            
            
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
