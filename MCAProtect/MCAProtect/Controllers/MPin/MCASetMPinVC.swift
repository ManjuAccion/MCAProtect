//
//  MCASetMPinVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/10/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASetMPinVC: UIViewController {
    
    
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

    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Custom Functions
    
    func loadUI() {
        
        self.newPinSecureInputTF.becomeFirstResponder()
    }
    
    //MARK: - IBActions Functions
    
    @IBAction func setPinButtonTapped(_ sender: Any) {
        
    }
    
}
