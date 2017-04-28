//
//  MCAProfileViewController.swift
//  MCAProtect
//
//  Created by Accion Labs on 17/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import SwiftyJSON
import Alamofire
import SDWebImage


class MCAProfileViewController: MCABaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImageView : UIImageView!
    @IBOutlet weak var firstNameTF : UITextField!
   
    @IBOutlet weak var phoneNumberTF : UITextField!
    @IBOutlet weak var emailTF : UITextField!
    @IBOutlet weak var emailOverlayView : MCARoundedOverlayView!
    @IBOutlet weak var updateButton : UIButton!
    @IBOutlet weak var cameraButton : UIButton!
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    
    var mcaUser : MCAUser!
    var imageData : NSData!
    var imageUrlString : String!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Profile"
        self.profileImageView.layer.borderWidth = 1.0;
        self.profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        self.profileImageView.layer.borderColor = ColorConstants.btnborderColor.cgColor
        profileImageView.clipsToBounds = true
         self.cameraButton.layer.cornerRadius = cameraButton.frame.height/2
        cameraButton.clipsToBounds = true

        updateButton.layer.cornerRadius = updateButton.frame.height/2

        
        let profileImageViewTapGesture =    UITapGestureRecognizer(target: self, action:#selector(selectImageFromSource))
        profileImageView.addGestureRecognizer(profileImageViewTapGesture)
        
        imagePicker?.delegate = self

        emailOverlayView.layer.borderColor = UIColor(red:166.0/255.0, green:42.0/255.0, blue:42.0/255.0, alpha: 0.5).cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        mcaUser = MCASessionManager.sharedSessionManager.mcapUser
        firstNameTF.text = mcaUser.brokerContactName
        emailTF.text = mcaUser.brokerEmail
        phoneNumberTF.text = mcaUser.brokerContactNumber
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            if let url =  self.mcaUser.brokerImageUrl {
                self.profileImageView.setIndicatorStyle(.gray)
                self.profileImageView.setShowActivityIndicator(true)
                let imageUrl = URL(string : url)
                self.profileImageView.sd_setImage(with: imageUrl)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
          }
    
    func keyboardWillHide(notification:NSNotification){
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.tag == 1) {
            self.topConstraints.constant = 0;
            UIView.animate(withDuration: 0.5, animations:
                {
                    self.view.layoutIfNeeded()
            })
        }
    }
    
     func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.tag == 1) {
            self.topConstraints.constant = -25;
            UIView.animate(withDuration: 0.5, animations:
                {
                    self.view.layoutIfNeeded()
            })
        }
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // MARK: - Set Profile Image
    @IBAction func setProfilePic() {
      selectImageFromSource()
    }
    
    override func updateImageView(image : UIImage) {
        self.profileImageView.contentMode = .scaleAspectFit
        self.profileImageView.setShowActivityIndicator(true)
        self.profileImageView.setIndicatorStyle(.gray)
        self.profileImageView.image = image
        
    }
    override func updateImageViewURL(imageURL : String) {
        self.imageUrlString = imageURL
        self.mcaUser.brokerImageUrl = self.imageUrlString
        self.profileImageView.sd_setImage(with: URL(string : self.imageUrlString))
        
    }

    
    @IBAction func updateProfileDetails() {
        
        if self.checkNetworkConnection() == false {
            return
        }
    
        self.showActivityIndicator()

        var paramDict  = Dictionary<String, String>()
        paramDict["contact_name"] = firstNameTF.text
        paramDict["contact_number"] = phoneNumberTF.text
        paramDict["image_url"] = MCASessionManager.sharedSessionManager.mcapUser.brokerImageUrl
        
        MCAWebServiceManager.sharedWebServiceManager.patchRequest(requestParam:paramDict,
                                                                 endPoint:MCAAPIEndPoints.BrokerUpdateProfileAPIEndpoint
            , successCallBack:{ (response : JSON!) in
                
                self.stopActivityIndicator()
                print("Success \(response)")
                MCASessionManager.sharedSessionManager.mcapUser = MCAUser(loginUserData:response, userLoginType: 0)
                let alertViewController = UIAlertController(title : "MCAP", message : "Profile Updated Successfully", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)

        },
               failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Update Failed", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
    }
}
  
