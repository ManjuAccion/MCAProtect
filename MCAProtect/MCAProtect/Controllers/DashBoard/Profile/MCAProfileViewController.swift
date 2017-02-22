//
//  MCAProfileViewController.swift
//  MCAProtect
//
//  Created by Accion Labs on 17/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class MCAProfileViewController: MCABaseViewController {
    
    @IBOutlet weak var profileImageButton : UIImageView!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var firstNameTF : JVFloatLabeledTextField!
    @IBOutlet weak var middleNameTF : JVFloatLabeledTextField!
    @IBOutlet weak var lastNameTF : JVFloatLabeledTextField!
    @IBOutlet weak var phoneNumberTF : JVFloatLabeledTextField!
    @IBOutlet weak var emailTF : JVFloatLabeledTextField!
    @IBOutlet weak var addressTF: JVFloatLabeledTextField!
    @IBOutlet weak var stateTF: JVFloatLabeledTextField!
    @IBOutlet weak var cityTF: JVFloatLabeledTextField!
    @IBOutlet weak var zipCodeTF: JVFloatLabeledTextField!

    

    



    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Profile"
        self.profileImageButton.layer.borderWidth = 1.0;
        self.profileImageButton.layer.cornerRadius = profileImageButton.frame.height/2
        self.profileImageButton.layer.borderColor = UIColor.white.cgColor
        profileImageButton.clipsToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)

        // Do any additional setup after loading the view.
    }
    
    
    func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero;
        scrollView.contentInset = contentInset
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.contentOffset = CGPoint(x: 0, y: -60)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
