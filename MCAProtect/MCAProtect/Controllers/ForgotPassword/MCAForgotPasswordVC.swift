//
//  MCAForgotPasswordVC.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit


class MCAForgotPasswordVC: MCABaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var forgotPasswordLabel : UILabel!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var overlayViewConstraint: NSLayoutConstraint!

    var isAllDetailsPresent : Bool? = true


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false;
        isAllDetailsPresent = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
            
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let enterMPinVC = storyboard.instantiateViewController(withIdentifier: "MCALoginViewController") as! MCALoginViewController
            self.navigationController?.pushViewController(enterMPinVC,
                                                          animated: true)
        }

        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
