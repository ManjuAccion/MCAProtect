//
//  MCAResetMPINVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/12/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class MCAResetMPINVC: MCABaseViewController,UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var emailIDTF: UITextField!
//    @IBOutlet weak var emailIDTF: JVFloatLabeledTextField!
    var activeTextField : UITextField?
    var toolbar : UIToolbar?
    var doneButton : UIBarButtonItem?
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilazeToolBar()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        registerForKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        self.view.endEditing(true)
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if ((emailIDTF.text?.isEmpty)!) {
            presentAlertWithTitle(title: "Error", message: NSLocalizedString("Please enter email id", comment: ""))
        }
        else if !(MCAUtilities.isValidEmail(inEmailId: emailIDTF.text!)) {
            presentAlertWithTitle(title: "Error", message: NSLocalizedString("Please enter valid email id", comment: ""))
        }
        else
        {
            let storyboard = UIStoryboard(name: "mPin", bundle: nil)
            let setMPinVC = storyboard.instantiateViewController(withIdentifier: "MCASetMPinVC") as! MCASetMPinVC
            navigationController?.pushViewController(setMPinVC,
                                                     animated: true)
        }
    }
    
    func loadUI() {
        
        loginButton.layer.cornerRadius = 5.0
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
    
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillBeShown(sender: NSNotification) {
        
//        let info: NSDictionary = sender.userInfo! as NSDictionary
//        let value: NSValue = info.value(forKey: UIKeyboardFrameBeginUserInfoKey) as! NSValue
//        let keyboardSize: CGSize = value.cgRectValue.size
//        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
//        scrollView.contentInset = contentInsets
//        scrollView.scrollIndicatorInsets = contentInsets
//        
//        // If active text field is hidden by keyboard, scroll it so it's visible
//        // Your app might not need or want this behavior.
//        var aRect: CGRect = self.view.frame
//        aRect.size.height -= keyboardSize.height
//        let activeTextFieldRect: CGRect? = activeTextField?.frame
//        let activeTextFieldOrigin: CGPoint? = activeTextFieldRect?.origin
//        if (!aRect.contains(activeTextFieldOrigin!)) {
//            scrollView.scrollRectToVisible(activeTextFieldRect!, animated:true)
//        }
        
        var userInfo = sender.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillBeHidden(sender: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(64.0, 0, 0, 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        activeTextField?.inputAccessoryView = toolbar
        activeTextField?.autocorrectionType = UITextAutocorrectionType.no
        scrollView.isScrollEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        activeTextField = nil
        scrollView.isScrollEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func inputToolbarDonePressed() {
        if activeTextField == emailIDTF {
            emailIDTF.resignFirstResponder()
        }
    }

}
