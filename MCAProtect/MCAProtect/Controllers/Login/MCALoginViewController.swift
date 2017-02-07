//
//  MCALoginViewController.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class MCALoginViewController: MCABaseViewController {
    @IBOutlet weak var emailIDTextField : JVFloatLabeledTextField!
    @IBOutlet weak var passwordTextField : JVFloatLabeledTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender:AnyObject){
        
        
        if ((emailIDTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!) {
            
            let alertViewController = UIAlertController(title : "Alert", message : "please fill the fields", preferredStyle : .alert)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
