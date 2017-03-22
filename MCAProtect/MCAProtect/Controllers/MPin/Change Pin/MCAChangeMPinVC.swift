//
//  MCAChangeMPinVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/11/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAChangeMPinVC: MCABaseViewController,UITextFieldDelegate {

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
        
        self.hideKeyboardWhenTappedAround()
        
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
        initialsecureInputViewSetup()

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
    
    func initialsecureInputViewSetup()
    {
       changeNewPinColor(color: UIColor.lightGray)
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
        changeConfirmPinColor(color: UIColor.lightGray)
        changeNewPinColor(color: UIColor.lightGray)
        changeOldPinColor(color:  ColorConstants.newRed)
    }
    
    func handleNewPinContainerViewTapGesture() {
        newPinSecureInputTF.becomeFirstResponder()
        changeNewPinColor(color: UIColor.red)
        changeConfirmPinColor(color: UIColor.lightGray)
        changeOldPinColor(color: UIColor.lightGray)

    }
    
    func handleConfirmPinContainerViewTapGesture() {
        confirmPinSecureInputTF.becomeFirstResponder()
        changeNewPinColor(color: UIColor.lightGray)
        changeConfirmPinColor(color: UIColor.red)
        changeOldPinColor(color: UIColor.lightGray)

    }
    
    
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShown(sender: NSNotification) {
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
    
    func keyboardWillHidden(sender: NSNotification) {
        
//        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(64.0, 0, 0, 0)
//        scrollView.contentInset = contentInsets
//        scrollView.scrollIndicatorInsets = contentInsets
        scrollView.isScrollEnabled = false
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
//                            oldPinSecureInputView1.inputImageView.image = UIImage(named:"pinPlacement")

                        case 2:
                            newPinSecureInputView1.inputImageView.isHidden = true
//                            newPinSecureInputView1.inputImageView.image = UIImage(named:"pinPlacement")

                        case 3:
                            confirmPinSecureInputView1.inputImageView.isHidden = true
//                            confirmPinSecureInputView1.inputImageView.image = UIImage(named:"pinPlacement")

                        default:
                            print("Default Value")
                    }
                }
                else {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView1.inputImageView.isHidden = false
//                        oldPinSecureInputView1.inputImageView.image = UIImage(named:"password")

                    case 2:
                        newPinSecureInputView1.inputImageView.isHidden = false
//                        newPinSecureInputView1.inputImageView.image = UIImage(named:"password")

                    case 3:
                        confirmPinSecureInputView1.inputImageView.isHidden = false
//                        confirmPinSecureInputView1.inputImageView.image = UIImage(named:"password")

                    default:
                        print("Default Value")
                    }
                }
            case 1:
                if string.isEmpty {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView2.inputImageView.isHidden = true
//                        oldPinSecureInputView2.inputImageView.image = UIImage(named:"pinPlacement")

                    case 2:
                        newPinSecureInputView2.inputImageView.isHidden = true
//                        newPinSecureInputView2.inputImageView.image = UIImage(named:"pinPlacement")

                    case 3:
                        confirmPinSecureInputView2.inputImageView.isHidden = true
//                        confirmPinSecureInputView2.inputImageView.image = UIImage(named:"pinPlacement")

                    default:
                        print("Default Value")
                    }
                }
                else {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView2.inputImageView.isHidden = false
//                        oldPinSecureInputView2.inputImageView.image = UIImage(named:"password")

                    case 2:
                        newPinSecureInputView2.inputImageView.isHidden = false
//                        newPinSecureInputView2.inputImageView.image = UIImage(named:"password")

                    case 3:
                        confirmPinSecureInputView2.inputImageView.isHidden = false
//                        confirmPinSecureInputView2.inputImageView.image = UIImage(named:"password")

                    default:
                        print("Default Value")
                    }
                }
            case 2:
                if string.isEmpty {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView3.inputImageView.isHidden = true
//                        oldPinSecureInputView3.inputImageView.image = UIImage(named:"pinPlacement")

                    case 2:
                        newPinSecureInputView3.inputImageView.isHidden = true
//                        newPinSecureInputView3.inputImageView.image = UIImage(named:"pinPlacement")

                    case 3:
                        confirmPinSecureInputView3.inputImageView.isHidden = true
//                        confirmPinSecureInputView3.inputImageView.image = UIImage(named:"pinPlacement")

                    default:
                        print("Default Value")
                    }
                }
                else {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView3.inputImageView.isHidden = false
//                        oldPinSecureInputView3.inputImageView.image = UIImage(named:"password")

                    case 2:
                        newPinSecureInputView3.inputImageView.isHidden = false
//                        newPinSecureInputView3.inputImageView.image = UIImage(named:"password")

                    case 3:
                        confirmPinSecureInputView3.inputImageView.isHidden = false
//                        confirmPinSecureInputView3.inputImageView.image = UIImage(named:"password")

                    default:
                        print("Default Value")
                    }
                }
            case 3:
                if string.isEmpty {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView4.inputImageView.isHidden = true
//                        oldPinSecureInputView4.inputImageView.image = UIImage(named:"pinPlacement")

                    case 2:
                        newPinSecureInputView4.inputImageView.isHidden = true
//                        newPinSecureInputView4.inputImageView.image = UIImage(named:"pinPlacement")

                    case 3:
                        confirmPinSecureInputView4.inputImageView.isHidden = true
//                        confirmPinSecureInputView4.inputImageView.image = UIImage(named:"pinPlacement")

                    default:
                        print("Default Value")
                    }
                }
                else {
                    switch textField.tag {
                    case 1:
                        oldPinSecureInputView4.inputImageView.isHidden = false
//                        oldPinSecureInputView4.inputImageView.image = UIImage(named:"password")

                    case 2:
                        newPinSecureInputView4.inputImageView.isHidden = false
//                        newPinSecureInputView4.inputImageView.image = UIImage(named:"password")

                    case 3:
                        confirmPinSecureInputView4.inputImageView.isHidden = false
//                        confirmPinSecureInputView4.inputImageView.image = UIImage(named:"password")

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
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
    }
    
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
            
            changeNewPinColor(color: UIColor.red)
            changeConfirmPinColor(color: UIColor.lightGray)
            changeOldPinColor(color: UIColor.lightGray)
            
            oldPinSecureInputTF.resignFirstResponder()
            newPinSecureInputTF.becomeFirstResponder()
        }
        else if activeTextField == newPinSecureInputTF {
            changeNewPinColor(color: UIColor.lightGray)
            changeConfirmPinColor(color: UIColor.red)
            changeOldPinColor(color: UIColor.lightGray)

            newPinSecureInputTF.resignFirstResponder()
            confirmPinSecureInputTF.becomeFirstResponder()
        }
        else {
            changeConfirmPinColor(color: UIColor.lightGray)
            changeNewPinColor(color: UIColor.lightGray)
            changeOldPinColor(color: UIColor.lightGray)
            confirmPinSecureInputTF.resignFirstResponder()
        }
    }
    
    
    func changeOldPinColor(color:UIColor)
    {
        oldPinSecureInputView1.initialPlaceholderView.backgroundColor = color
        oldPinSecureInputView2.initialPlaceholderView.backgroundColor = color
        oldPinSecureInputView3.initialPlaceholderView.backgroundColor = color
        oldPinSecureInputView4.initialPlaceholderView.backgroundColor = color
        
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
