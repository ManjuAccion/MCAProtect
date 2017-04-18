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
    
    var activeTextField : UITextField?
    var toolbar : UIToolbar?
    var doneButton : UIBarButtonItem?
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forgot PIN"

        initilazeToolBar()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
        loadUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        self.view.endEditing(true)
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Action Methods

    
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
        
        loginButton.layer.cornerRadius = loginButton.frame.height/2
    }
    
    func initilazeToolBar() {
        toolbar = UIToolbar()
        toolbar?.isTranslucent = false
        toolbar?.barTintColor = UIColor.darkGray
        toolbar?.sizeToFit()
        
        doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.inputToolbarDonePressed))
        doneButton?.tintColor = .white
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar?.setItems([flexibleSpaceButton, doneButton!], animated: false)
        toolbar?.isUserInteractionEnabled = true
        
    }
    
    //MARK: - Keyboard Notifcations
    
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillBeShown(sender: NSNotification) {
        var userInfo = sender.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
    }
    
    func keyboardWillBeHidden(sender: NSNotification) {
    }
    
    //MARK: - UITextfield Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        activeTextField?.inputAccessoryView = toolbar
        activeTextField?.autocorrectionType = UITextAutocorrectionType.no
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
