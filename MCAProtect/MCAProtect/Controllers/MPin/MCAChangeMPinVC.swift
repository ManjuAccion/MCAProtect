//
//  MCAChangeMPinVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/11/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAChangeMPinVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var oldPinSecureInputView1: SecureInputView!
    @IBOutlet weak var oldPinSecureInputView2: SecureInputView!
    @IBOutlet weak var oldPinSecureInputView3: SecureInputView!
    @IBOutlet weak var oldPinSecureInputView4: SecureInputView!
    @IBOutlet weak var oldPinSecureInputTF: UITextField!
    
    @IBOutlet weak var newPinSecureInputView1: SecureInputView!
    @IBOutlet weak var newPinSecureInputView2: SecureInputView!
    @IBOutlet weak var newPinSecureInputView3: SecureInputView!
    @IBOutlet weak var newPinSecureInputView4: SecureInputView!
    @IBOutlet weak var newPinSecureInputTF: UITextField!
    
    @IBOutlet weak var confirmPinSecureInputView1: SecureInputView!
    @IBOutlet weak var confirmPinSecureInputView2: SecureInputView!
    @IBOutlet weak var confirmPinSecureInputView3: SecureInputView!
    @IBOutlet weak var confirmPinSecureInputView4: SecureInputView!
    @IBOutlet weak var confirmPinSecureInputTF: UITextField!
    
    @IBOutlet weak var setPinButton: UIButton!
    
    @IBOutlet weak var oldPinSecureInputContainerView: UIView!
    @IBOutlet weak var confirmPinSecureInputContainerView: UIView!
    @IBOutlet weak var newPinSecureInputContainerView: UIView!
    
    
    var activeTextField : UITextField?
    var toolbar : UIToolbar?
    var doneButton : UIBarButtonItem?

    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oldPinContainerViewTapGesture = UITapGestureRecognizer(target: self, action:#selector(handleOldPinContainerViewTapGesture))
        oldPinSecureInputContainerView.addGestureRecognizer(oldPinContainerViewTapGesture)
        
        let newPinContainerViewTapGesture = UITapGestureRecognizer(target: self, action:#selector(handleNewPinContainerViewTapGesture))
        newPinSecureInputContainerView.addGestureRecognizer(newPinContainerViewTapGesture)
        
        let confirmContainerViewTapGesture = UITapGestureRecognizer(target: self, action:#selector(handleConfirmPinContainerViewTapGesture))
        confirmPinSecureInputContainerView.addGestureRecognizer(confirmContainerViewTapGesture)
        
        initilazeToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    func loadUI() {
        setPinButton.layer.cornerRadius = 5.0
        oldPinSecureInputTF.becomeFirstResponder()
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
    
    
    @IBAction func setPinButtonTapped(_ sender: Any) {
        
        if (oldPinSecureInputTF.text?.isEmpty)! || (oldPinSecureInputTF.text?.characters.count)! < 4 {
            presentAlertWithTitle(title: "Error", message: NSLocalizedString("Please enter old pin", comment: ""))
        }
        if (newPinSecureInputTF.text?.isEmpty)! || (newPinSecureInputTF.text?.characters.count)! < 4 {
            presentAlertWithTitle(title: "Error", message: NSLocalizedString("Please enter new pin", comment: ""))
        }
        if (confirmPinSecureInputTF.text?.isEmpty)! || (confirmPinSecureInputTF.text?.characters.count)! < 4 {
            presentAlertWithTitle(title: "Error", message: NSLocalizedString("Please enter confirm pin", comment: ""))
        }
        if (newPinSecureInputTF.text?.characters.count == 4 && confirmPinSecureInputTF.text?.characters.count == 4 && oldPinSecureInputTF.text?.characters.count == 4) && newPinSecureInputTF.text == confirmPinSecureInputTF.text {

            let alert = UIAlertController(title: "Alert", message: NSLocalizedString("Your new mPin is set successfully.", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: ""), style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
                
                let mPinStoryBoard = UIStoryboard(name : "mPin", bundle : nil)
                let mPin = mPinStoryBoard.instantiateViewController(withIdentifier: "MCAEnterMPinVC") as! MCAEnterMPinVC
                self.navigationController?.pushViewController(mPin, animated: true)
            }));
            present(alert, animated: true, completion: nil);

        }
        else
        {
            presentAlertWithTitle(title: "Error", message: "mPin doesn't match")
        }
    }
    

    
    func handleOldPinContainerViewTapGesture() {
        oldPinSecureInputTF.becomeFirstResponder()
    }
    
    func handleNewPinContainerViewTapGesture() {
        newPinSecureInputTF.becomeFirstResponder()
    }
    
    func handleConfirmPinContainerViewTapGesture() {
        confirmPinSecureInputTF.becomeFirstResponder()
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
        aRect.size.height -= keyboardSize.height + 44
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
    
    //MARK: - UITextFiled Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.characters.count <= 3 && range.location <= 3 {
            switch range.location {
                
            case 0:
                if string.isEmpty {
                    switch textField.tag {
                        case 1:
                            oldPinSecureInputView1.inputImageView.isHidden = true
                        case 2:
                            newPinSecureInputView1.inputImageView.isHidden = true
                        case 3:
                            confirmPinSecureInputView1.inputImageView.isHidden = true
                        default:
                            print("Default Value")
                    }
                }
                else {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView1.inputImageView.isHidden = false
                    case 2:
                        newPinSecureInputView1.inputImageView.isHidden = false
                    case 3:
                        confirmPinSecureInputView1.inputImageView.isHidden = false
                    default:
                        print("Default Value")
                    }
                }
            case 1:
                if string.isEmpty {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView2.inputImageView.isHidden = true
                    case 2:
                        newPinSecureInputView2.inputImageView.isHidden = true
                    case 3:
                        confirmPinSecureInputView2.inputImageView.isHidden = true
                    default:
                        print("Default Value")
                    }
                }
                else {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView2.inputImageView.isHidden = false
                    case 2:
                        newPinSecureInputView2.inputImageView.isHidden = false
                    case 3:
                        confirmPinSecureInputView2.inputImageView.isHidden = false
                    default:
                        print("Default Value")
                    }
                }
            case 2:
                if string.isEmpty {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView3.inputImageView.isHidden = true
                    case 2:
                        newPinSecureInputView3.inputImageView.isHidden = true
                    case 3:
                        confirmPinSecureInputView3.inputImageView.isHidden = true
                    default:
                        print("Default Value")
                    }
                }
                else {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView3.inputImageView.isHidden = false
                    case 2:
                        newPinSecureInputView3.inputImageView.isHidden = false
                    case 3:
                        confirmPinSecureInputView3.inputImageView.isHidden = false
                    default:
                        print("Default Value")
                    }
                }
            case 3:
                if string.isEmpty {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView4.inputImageView.isHidden = true
                    case 2:
                        newPinSecureInputView4.inputImageView.isHidden = true
                    case 3:
                        confirmPinSecureInputView4.inputImageView.isHidden = true
                    default:
                        print("Default Value")
                    }
                }
                else {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView4.inputImageView.isHidden = false
                    case 2:
                        newPinSecureInputView4.inputImageView.isHidden = false
                    case 3:
                        confirmPinSecureInputView4.inputImageView.isHidden = false
                    default:
                        print("Default Value")
                    }
                }
            default:
                print("Default Value")
            }
            
            return true
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        activeTextField?.inputAccessoryView = toolbar
        activeTextField?.autocorrectionType = UITextAutocorrectionType.no
        scrollView.isScrollEnabled = true
        if textField == oldPinSecureInputTF || textField == newPinSecureInputTF {
            doneButton?.title = "Next"
        }
        else {
            doneButton?.title = "Done"
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        activeTextField = nil
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(64.0, 0, 0, 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == oldPinSecureInputTF {
            textField.resignFirstResponder()
            newPinSecureInputTF.becomeFirstResponder()
        }
        else if textField == newPinSecureInputTF {
            textField.resignFirstResponder()
            confirmPinSecureInputTF.becomeFirstResponder()
        }
        else {
            confirmPinSecureInputTF.resignFirstResponder()
        }
        return true
    }
    
    func inputToolbarDonePressed() {
        if activeTextField == oldPinSecureInputTF {
            oldPinSecureInputTF.resignFirstResponder()
            newPinSecureInputTF.becomeFirstResponder()
        }
        else if activeTextField == newPinSecureInputTF {
            newPinSecureInputTF.resignFirstResponder()
            confirmPinSecureInputTF.becomeFirstResponder()
        }
        else {
            confirmPinSecureInputTF.resignFirstResponder()
        }
    }

}
