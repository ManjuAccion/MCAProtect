//
//  MCARegistrationVC.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCARegistrationVC: MCABaseViewController,UITextFieldDelegate {
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var businessNameTF : UITextField!
    @IBOutlet weak var emailTF : UITextField!
    @IBOutlet weak var phoneNumberTF : UITextField!
    @IBOutlet weak var passwordTF : UITextField!
    @IBOutlet weak var confirmPasswordTF : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.navigationController?.navigationBar.isHidden = false
       


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.contentOffset = CGPoint(x: 0, y: -60)
        return true
    }
    
    @IBAction func registerButtonPressed (sender : AnyObject){
        
    if ((businessNameTF.text?.isEmpty)!)
    {
    
    let alertViewController = UIAlertController(title : "Alert", message : "please fill the fields", preferredStyle : .alert)
    alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
    
    present(alertViewController, animated: true , completion: nil)
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
