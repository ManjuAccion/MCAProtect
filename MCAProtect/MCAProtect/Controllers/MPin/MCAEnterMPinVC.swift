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
    var toolbar : UIToolbar?
    var doneButton : UIBarButtonItem?
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secureInputTF.becomeFirstResponder()
        self.hideKeyboardWhenTappedAround()
        
        let newPinContainerViewTapGesture = UITapGestureRecognizer(target: self, action:#selector(handleSecureInputContainerViewTapGesture))
        secureInputContainerView.addGestureRecognizer(newPinContainerViewTapGesture)
        initilazeToolBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        registerForKeyboardNotifications()
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
    
    func loadUI() {
        secureInputTF.autocorrectionType = UITextAutocorrectionType.no
        loginButton.layer.cornerRadius = loginButton.frame.height/2
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
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
//    func keyboardWillBeShown(sender: NSNotification) {
//        
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
//    }
//    
//    func keyboardWillBeHidden(sender: NSNotification) {
//        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(64.0, 0, 0, 0)
//        scrollView.contentInset = contentInsets
//        scrollView.scrollIndicatorInsets = contentInsets
//    }
//  
    func inputToolbarDonePressed() {
        secureInputTF.resignFirstResponder()
    }

    
    //MARK: - UITextFiled Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        activeTextField?.inputAccessoryView = toolbar
        activeTextField?.autocorrectionType = UITextAutocorrectionType.no
//        scrollView.isScrollEnabled = true
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
//                    secureInputView1.inputImageView.isHidden = true
                    secureInputView1.inputImageView.image = UIImage(named:"pinPlacement")

                }
                else {
//                    secureInputView1.inputImageView.isHidden = false
                    secureInputView1.inputImageView.image = UIImage(named:"password")
                }
                
            case 1:
                if string.isEmpty {
//                    secureInputView2.inputImageView.isHidden = true
                    secureInputView2.inputImageView.image = UIImage(named:"pinPlacement")
                }
                else {
//                    secureInputView2.inputImageView.isHidden = false
                    secureInputView2.inputImageView.image = UIImage(named:"password")
                }
            case 2:
                if string.isEmpty {
//                    secureInputView2.inputImageView.isHidden = true
                    secureInputView3.inputImageView.image = UIImage(named:"pinPlacement")
                }
                else {
//                    secureInputView2.inputImageView.isHidden = false
                    secureInputView3.inputImageView.image = UIImage(named:"password")
                }

            case 3:
                if string.isEmpty {
//                    secureInputView2.inputImageView.isHidden = true
                    secureInputView4.inputImageView.image = UIImage(named:"pinPlacement")
                }
                else {
//                    secureInputView2.inputImageView.isHidden = false
                    secureInputView4.inputImageView.image = UIImage(named:"password")
                }

            default:
                print("Default Value")
            }
            
            return true
        }
        return false
    }
    

    
}


