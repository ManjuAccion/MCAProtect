//
//  MCAEnterMPinVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/9/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAEnterMPinVC: MCABaseViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var changeMPinButton: UIButton!
    @IBOutlet weak var forgotMPinButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var secureInputTF: UITextField!
    
    @IBOutlet weak var secureInputView1: SecureInputView!
    @IBOutlet weak var secureInputView2: SecureInputView!
    @IBOutlet weak var secureInputView3: SecureInputView!
    @IBOutlet weak var secureInputView4: SecureInputView!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadUI() {
        
        self.secureInputTF.becomeFirstResponder()
        self.secureInputView1.inputImageView.isHidden = true
        self.secureInputView2.inputImageView.isHidden = true
        
        self.secureInputView3.inputImageView.isHidden = true
        self.secureInputView4.inputImageView.isHidden = true
    }
    
    //MARK :- IBAction Actions
    
    @IBAction func changeMPinTapped(_ sender: Any) {
        
    }
    
    @IBAction func forgotMPinTapped(_ sender: Any) {
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
    }
    
    //MARK: - UITextFiled Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.characters.count <= 3 && range.location <= 3 {
            switch range.location {
                
            case 0:
                if string.isEmpty {
                    self.secureInputView1.inputImageView.isHidden = true
                }
                else {
                    self.secureInputView1.inputImageView.isHidden = false
                }
                
            case 1:
                if string.isEmpty {
                    self.secureInputView2.inputImageView.isHidden = true
                }
                else {
                    self.secureInputView2.inputImageView.isHidden = false
                }
            case 2:
                if string.isEmpty {
                    self.secureInputView3.inputImageView.isHidden = true
                }
                else {
                    self.secureInputView3.inputImageView.isHidden = false
                }
            case 3:
                if string.isEmpty {
                    self.secureInputView4.inputImageView.isHidden = true
                }
                else {
                    self.secureInputView4.inputImageView.isHidden = false
                }
            default:
                print("Default Value")
            }
            
            return true
        }
        return false
    }

    
}


