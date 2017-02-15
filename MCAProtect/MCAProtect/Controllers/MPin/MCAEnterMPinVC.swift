//
//  MCAEnterMPinVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/9/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAEnterMPinVC: MCABaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var changeMPinButton: UIButton!
    @IBOutlet weak var forgotMPinButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var secureInputTF: UITextField!
    
    @IBOutlet weak var secureInputContainerView: UIView!
    @IBOutlet weak var secureInputView1: SecureInputView!
    @IBOutlet weak var secureInputView2: SecureInputView!
    @IBOutlet weak var secureInputView3: SecureInputView!
    @IBOutlet weak var secureInputView4: SecureInputView!
    
    var activeTextField : UITextField?
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadUI() {
        
        secureInputTF.becomeFirstResponder()
        secureInputView1.inputImageView.isHidden = true
        secureInputView2.inputImageView.isHidden = true
        
        secureInputView3.inputImageView.isHidden = true
        secureInputView4.inputImageView.isHidden = true
        
        secureInputTF.autocorrectionType = UITextAutocorrectionType.no
        loginButton.layer.cornerRadius = 5.0
        
        let newPinContainerViewTapGesture = UITapGestureRecognizer(target: self, action:#selector(handleSecureInputContainerViewTapGesture))
        secureInputContainerView.addGestureRecognizer(newPinContainerViewTapGesture)
        registerForKeyboardNotifications()
    }
    
    func handleSecureInputContainerViewTapGesture() {
        secureInputTF.becomeFirstResponder()
    }
    
    //MARK :- IBAction Actions
    
    @IBAction func changeMPinTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "mPin", bundle: nil)
        let changeMPinVC = storyboard.instantiateViewController(withIdentifier: "MCAChangeMPinVC") as! MCAChangeMPinVC
        navigationController?.pushViewController(changeMPinVC,
                                                 animated: true)
    }
    
    @IBAction func forgotMPinTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "mPin", bundle: nil)
        let resetMPinVC = storyboard.instantiateViewController(withIdentifier: "MCAResetMPINVC") as! MCAResetMPINVC
        navigationController?.pushViewController(resetMPinVC,
                                                 animated: true)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if ((secureInputTF.text?.isEmpty)!) || (secureInputTF.text?.characters.count)! < 4{
            presentAlertWithTitle(title: "Error", message: NSLocalizedString("Please enter mPin", comment: ""))
        }
        else {
            let storyboard = UIStoryboard(name: "DashBoard", bundle: nil)
            let dashboardVC = storyboard.instantiateViewController(withIdentifier: "MCADashboardTabbarVC") as! MCADashboardTabbarVC
            self.navigationController?.pushViewController(dashboardVC,
                                                          animated: true)

        }
    }
    
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillBeShown(sender: NSNotification) {
        
        let info: NSDictionary = sender.userInfo! as NSDictionary
        let value: NSValue = info.value(forKey: UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.cgRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        var aRect: CGRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        let activeTextFieldRect: CGRect? = activeTextField?.frame
        let activeTextFieldOrigin: CGPoint? = activeTextFieldRect?.origin
        if (!aRect.contains(activeTextFieldOrigin!)) {
            scrollView.scrollRectToVisible(activeTextFieldRect!, animated:true)
        }
    }
    
    func keyboardWillBeHidden(sender: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(64.0, 0, 0, 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    lazy var inputToolbar: UIToolbar = {
        var toolbar = UIToolbar()
        toolbar.barStyle = .blackTranslucent
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.inputToolbarDonePressed))
        var flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
 
        toolbar.setItems([flexibleSpaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }()
    
    func inputToolbarDonePressed() {
        secureInputTF.resignFirstResponder()
    }

    
    //MARK: - UITextFiled Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        activeTextField?.inputAccessoryView = inputToolbar
        activeTextField?.autocorrectionType = UITextAutocorrectionType.no
        scrollView.isScrollEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        activeTextField = nil
//        scrollView.isScrollEnabled = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.characters.count <= 3 && range.location <= 3 {
            switch range.location {
                
            case 0:
                if string.isEmpty {
                    secureInputView1.inputImageView.isHidden = true
                }
                else {
                    secureInputView1.inputImageView.isHidden = false
                }
                
            case 1:
                if string.isEmpty {
                    secureInputView2.inputImageView.isHidden = true
                }
                else {
                    secureInputView2.inputImageView.isHidden = false
                }
            case 2:
                if string.isEmpty {
                    secureInputView3.inputImageView.isHidden = true
                }
                else {
                    secureInputView3.inputImageView.isHidden = false
                }
            case 3:
                if string.isEmpty {
                    secureInputView4.inputImageView.isHidden = true
                }
                else {
                    secureInputView4.inputImageView.isHidden = false
                }
            default:
                print("Default Value")
            }
            
            return true
        }
        return false
    }
    

    
}


