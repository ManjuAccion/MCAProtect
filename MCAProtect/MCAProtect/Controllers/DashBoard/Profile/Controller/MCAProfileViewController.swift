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
    var imagePicker:UIImagePickerController?=UIImagePickerController()
    

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

        
        let profileImageViewTapGesture =    UITapGestureRecognizer(target: self, action:#selector(updateProfilePic))
        profileImageView.addGestureRecognizer(profileImageViewTapGesture)
        
        imagePicker?.delegate = self

        emailOverlayView.layer.borderColor = UIColor(red:166.0/255.0, green:42.0/255.0, blue:42.0/255.0, alpha: 0.5).cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        mcaUser = MCASessionManager.sharedSessionManager.mcapUser
        firstNameTF.text = mcaUser.brokerContactName
        emailTF.text = mcaUser.brokerEmail
        phoneNumberTF.text = mcaUser.brokerContactNumber
        
                   // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
     
  
        
        DispatchQueue.main.async {
            if let url =  self.mcaUser.brokerImageUrl {
                self.profileImageView.setIndicatorStyle(.gray)
                self.profileImageView.setShowActivityIndicator(true)
                let imageUrl = NSURL(string : url)
                self.profileImageView.sd_setImage(with: imageUrl as URL!)
               
            }
 
        }
       
    }
    
    
    func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
          }
    
    func keyboardWillHide(notification:NSNotification){
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if(textField.tag == 1) {
            self.topConstraints.constant = 0;
            UIView.animate(withDuration: 0.5, animations:
                {
                    self.view.layoutIfNeeded()
            })
        }

    }
    
     func textFieldDidBeginEditing(_ textField: UITextField)
     {
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Set Profile Image
    @IBAction func setProfilePic()
    {
      updateProfilePic()
        
    }
    
     func updateProfilePic()
    {
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        // Add the actions
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        }
        
    

    func openCamera()
    {
    
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            imagePicker!.sourceType = .camera
            self.present(imagePicker!, animated: true, completion: nil)
        }
           }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        {
            self.imagePicker!.sourceType = .savedPhotosAlbum;
            imagePicker!.allowsEditing = false
            self.present(imagePicker!, animated: true, completion: nil)
 
        
    }
        }
    
    
    func getDirectoryPath() -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    // MARK: - Image Picker Controller Delegates

    
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if self.checkNetworkConnection() == false {
            return
        }

        let profileImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    
        self.showActivityIndicator()

        let data = UIImageJPEGRepresentation(profileImage, 80)
        // Save cloned image into document directory
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("test.jpg")
        
        do {
            try data?.write(to: fileURL, options: .atomic)
        } catch {
            print(error)
        }
        
        var paramDict  = Dictionary<String,Any>()
        paramDict["file"] = fileURL
        
        MCAWebServiceManager.sharedWebServiceManager.uploadImageRequest(requestParam:paramDict,
                                                                        endPoint:"",imageData: data!
            , successCallBack:{ (response : JSON!) in
                
                self.stopActivityIndicator()
                print("Success \(response)")
                self.imageUrlString = response["image_url"].stringValue
                MCASessionManager.sharedSessionManager.mcapUser.brokerImageUrl = self.imageUrlString
                
        },
              failureCallBack: { (error : Error) in
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Upload failed", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
        
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.image = profileImage
        dismiss(animated:true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
      
    @IBAction func updateProfileDetails()
    {
        
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
  
