//
//  MCASetMPinVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/10/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASetMPinVC: MCABaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
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
    @IBOutlet weak var newPinSecureInputContainerView: UIView!
    @IBOutlet weak var confirmPinSecureInputContainerView: UIView!
    
    var activeTextField : UITextField?
    var isFromRegistrationFlow : Bool?
    var toolbar : UIToolbar?
    var doneButton : UIBarButtonItem?
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Set PIN"
        
        self.hideKeyboardWhenTappedAround()

        let newPinContainerViewTapGesture = UITapGestureRecognizer(target: self, action:#selector(handleNewPinContainerViewTapGesture))
        newPinSecureInputContainerView.addGestureRecognizer(newPinContainerViewTapGesture)
        
        let confirmContainerViewTapGesture = UITapGestureRecognizer(target: self, action:#selector(handleConfirmPinContainerViewTapGesture))
        confirmPinSecureInputContainerView.addGestureRecognizer(confirmContainerViewTapGesture)
        initilazeToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     //   self.navigationController?.setNavigationBarHidden(true, animated: animated)

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

    
    //MARK: - Custom Functions
    
    func loadUI() {

        setPinButton.layer.cornerRadius = setPinButton.frame.height/2
        newPinSecureInputTF.becomeFirstResponder()
        changeNewPinColor(color: UIColor.red)
        changeConfirmPinColor(color: UIColor.lightGray)


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
    
    func handleNewPinContainerViewTapGesture() {
        newPinSecureInputTF.becomeFirstResponder()
        changeNewPinColor(color: UIColor.red)
        changeConfirmPinColor(color: UIColor.lightGray)

    }
    
    func handleConfirmPinContainerViewTapGesture() {
        confirmPinSecureInputTF.becomeFirstResponder()
        changeConfirmPinColor(color: UIColor.red)
        changeNewPinColor(color: UIColor.lightGray)

    }

    
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillBeShown(sender: NSNotification) {
        
        scrollView.isScrollEnabled = true
        
        let info: NSDictionary = sender.userInfo! as NSDictionary
        let value: NSValue = info.value(forKey: UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.cgRectValue.size
        
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        
        var aRect: CGRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        
        let activeTextFieldRect = activeTextField?.convert((activeTextField?.frame)!, to: scrollView)
        let activeTextFieldOrigin: CGPoint? = activeTextFieldRect?.origin
        
        if (!aRect.contains(activeTextFieldOrigin!)) {
            scrollView.scrollRectToVisible(activeTextFieldRect!, animated:true)
        }
    }
    
    func keyboardWillBeHidden(sender: NSNotification) {
//        scrollView.isScrollEnabled = false
    }
    
    //MARK: - IBActions Functions
    
    @IBAction func setPinButtonTapped(_ sender: Any) {
        self.view.endEditing(true)

        if (newPinSecureInputTF.text?.isEmpty)! || (newPinSecureInputTF.text?.characters.count)! < 4 {
            presentAlertWithTitle(title: "Error", message: NSLocalizedString("Please enter new pin", comment: ""))
        }
        if (confirmPinSecureInputTF.text?.isEmpty)! || (confirmPinSecureInputTF.text?.characters.count)! < 4 {
            presentAlertWithTitle(title: "Error", message: NSLocalizedString("Please enter confirm pin", comment: ""))
        }
        if (newPinSecureInputTF.text?.characters.count == 4 && confirmPinSecureInputTF.text?.characters.count == 4) && newPinSecureInputTF.text == confirmPinSecureInputTF.text {

            let alert = UIAlertController(title: "Alert", message: NSLocalizedString("Your mPin is set successfully.", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: ""), style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in

                if self.isFromRegistrationFlow == true {
                    let storyboard = UIStoryboard(name: "Login", bundle: nil)
                    let enterMPinVC = storyboard.instantiateViewController(withIdentifier: "MCALoginViewController") as! MCALoginViewController
                    self.navigationController?.pushViewController(enterMPinVC,
                                                                  animated: true)
                }
                else
                {
                    let storyboard = UIStoryboard(name: "mPin", bundle: nil)
                    let enterMPinVC = storyboard.instantiateViewController(withIdentifier: "MCAEnterMPinVC") as! MCAEnterMPinVC
                    self.navigationController?.pushViewController(enterMPinVC,
                                                                  animated: true)
                }
            }));
            present(alert, animated: true, completion: nil);
        }
        else
        {
            presentAlertWithTitle(title: "Error", message: "mPin doesn't match")
        }
    }
    
    //MARK: - UITextFiled Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.characters.count <= 3 && range.location <= 3 {
            switch range.location {
                
            case 0:
                if string.isEmpty {
                    if textField.tag == 1
                    {
                        newPinSecureInputView1.inputImageView.isHidden = true
//                        newPinSecureInputView1.inputImageView.image = UIImage(named:"pinPlacement")

                    }
                    else
                    {
                        confirmPinSecureInputView1.inputImageView.isHidden = true
//                        confirmPinSecureInputView1.inputImageView.image = UIImage(named:"pinPlacement")

                    }
                }
                else {
                    if(textField.tag == 1)
                    {
                        newPinSecureInputView1.inputImageView.isHidden = false
//                        newPinSecureInputView1.inputImageView.image = UIImage(named:"password")

                        
                    }
                    else
                    {
                        confirmPinSecureInputView1.inputImageView.isHidden = false
//                        confirmPinSecureInputView1.inputImageView.image = UIImage(named:"password")

                    }
                }
                
            case 1:
                if string.isEmpty {
                    if textField.tag == 1
                    {
                        newPinSecureInputView2.inputImageView.isHidden = true
//                        newPinSecureInputView2.inputImageView.image = UIImage(named:"pinPlacement")

                    }
                    else
                    {
                        confirmPinSecureInputView2.inputImageView.isHidden = true
//                        confirmPinSecureInputView2.inputImageView.image = UIImage(named:"pinPlacement")

                    }
                }
                else {
                    if(textField.tag == 1)
                    {
                        newPinSecureInputView2.inputImageView.isHidden = false
//                        newPinSecureInputView2.inputImageView.image = UIImage(named:"password")

                    }
                    else
                    {
                        confirmPinSecureInputView2.inputImageView.isHidden = false
//                        confirmPinSecureInputView2.inputImageView.image = UIImage(named:"password")

                    }
                }

            case 2:
                if string.isEmpty {
                    if textField.tag == 1
                    {
                        newPinSecureInputView3.inputImageView.isHidden = true
//                        newPinSecureInputView3.inputImageView.image = UIImage(named:"pinPlacement")

                    }
                    else
                    {
                        confirmPinSecureInputView3.inputImageView.isHidden = true
//                        confirmPinSecureInputView3.inputImageView.image = UIImage(named:"pinPlacement")

                    }
                }
                else {
                    if(textField.tag == 1)
                    {
                        newPinSecureInputView3.inputImageView.isHidden = false
//                        newPinSecureInputView3.inputImageView.image = UIImage(named:"password")

                    }
                    else
                    {
                        confirmPinSecureInputView3.inputImageView.isHidden = false
//                        confirmPinSecureInputView3.inputImageView.image = UIImage(named:"password")

                    }
                }

            case 3:
                if string.isEmpty {
                    if textField.tag == 1
                    {
                        newPinSecureInputView4.inputImageView.isHidden = true
//                        newPinSecureInputView4.inputImageView.image = UIImage(named:"pinPlacement")

                    }
                    else
                    {
                        confirmPinSecureInputView4.inputImageView.isHidden = true
//                        confirmPinSecureInputView4.inputImageView.image = UIImage(named:"pinPlacement")
                    }
                }
                else {
                    if(textField.tag == 1)
                    {
                        newPinSecureInputView4.inputImageView.isHidden = false
//                        newPinSecureInputView4.inputImageView.image = UIImage(named:"password")

                    }
                    else
                    {
                        confirmPinSecureInputView4.inputImageView.isHidden = false
//                        confirmPinSecureInputView4.inputImageView.image = UIImage(named:"password")

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
        if textField == self.newPinSecureInputTF {
            doneButton?.title = "Next"
        }
        else{
            doneButton?.title = "Done"
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.newPinSecureInputTF {
            textField.resignFirstResponder()
            confirmPinSecureInputTF.becomeFirstResponder()
        }
        else if textField == self.confirmPinSecureInputTF {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func inputToolbarDonePressed() {
        if activeTextField == self.newPinSecureInputTF {
            self.newPinSecureInputTF.resignFirstResponder()
            confirmPinSecureInputTF.becomeFirstResponder()
            changeConfirmPinColor(color: UIColor.red)
            changeNewPinColor(color: UIColor.lightGray)

        }
        else if activeTextField == self.confirmPinSecureInputTF {
            confirmPinSecureInputTF.resignFirstResponder()
            changeConfirmPinColor(color: UIColor.lightGray)
            changeNewPinColor(color: UIColor.lightGray)
        }
    }
    
    
    func changeNewPinColor(color:UIColor)
    {
        newPinSecureInputView1.initialPlaceholderView.backgroundColor = color
        newPinSecureInputView2.initialPlaceholderView.backgroundColor = color
        newPinSecureInputView3.initialPlaceholderView.backgroundColor = color
        newPinSecureInputView4.initialPlaceholderView.backgroundColor = color
        
    }
    func changeConfirmPinColor(color:UIColor)
    {
        
        confirmPinSecureInputView1.initialPlaceholderView.backgroundColor = color
        confirmPinSecureInputView2.initialPlaceholderView.backgroundColor = color
        confirmPinSecureInputView3.initialPlaceholderView.backgroundColor = color
        confirmPinSecureInputView4.initialPlaceholderView.backgroundColor = color
        
    }

}


