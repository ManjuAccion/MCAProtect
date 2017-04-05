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


class MCAProfileViewController: MCABaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImageButton : UIButton!
    @IBOutlet weak var firstNameTF : UITextField!
   
    @IBOutlet weak var phoneNumberTF : UITextField!
    @IBOutlet weak var emailTF : UITextField!
    @IBOutlet weak var emailOverlayView : MCARoundedOverlayView!
    @IBOutlet weak var updateButton : UIButton!
    @IBOutlet weak var cameraButton : UIButton!
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    
    var mcaUser : MCAUser!
    var imageData : NSData!
    var imagePicker:UIImagePickerController?=UIImagePickerController()
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Profile"
        self.profileImageButton.layer.borderWidth = 1.0;
        self.profileImageButton.layer.cornerRadius = profileImageButton.frame.height/2
        self.profileImageButton.layer.borderColor = ColorConstants.btnborderColor.cgColor
        profileImageButton.clipsToBounds = true
         self.cameraButton.layer.cornerRadius = cameraButton.frame.height/2
        cameraButton.clipsToBounds = true

        updateButton.layer.cornerRadius = updateButton.frame.height/2

        imagePicker?.delegate = self

        emailOverlayView.layer.borderColor = UIColor(red:166.0/255.0, green:42.0/255.0, blue:42.0/255.0, alpha: 0.5).cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        mcaUser = MCASessionManager.sharedSessionManager.mcapUser
        firstNameTF.text = mcaUser.brokerContactName
        emailTF.text = mcaUser.brokerEmail
        phoneNumberTF.text = mcaUser.brokerContactNumber
        
//       let imageUrl = NSURL(string : mcaUser.brokerImageUrl)
//        let data = NSData(contentsOf:imageUrl! as URL)
//        if data != nil {
//            profileImageButton.setImage(UIImage(data:data as! Data), for: UIControlState.normal)
//        }

        // Do any additional setup after loading the view.
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

    
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let profileImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        


      //  self.showActivityIndicator()

        var paramDict  = Dictionary<String,Any>()
        paramDict["file"] = ""
        paramDict["file_name"] = "profileImage"
        paramDict["file_extension"] = ".png"

        let parameters = [
            "file_name": "profile_image.jpeg"
        ]
        
        
        // Set static name, so everytime image is cloned, it will be named "temp", thus rewrite the last "temp" image.
        // *Don't worry it won't be shown in Photos app.
        
        // Encode this image into JPEG. *You can add conditional based on filetype, to encode into JPEG or PNG
         let data = UIImageJPEGRepresentation(profileImage, 80)
            // Save cloned image into document directory
            
            let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("test.jpg")
            
            do {
                try data?.write(to: fileURL, options: .atomic)
            } catch {
                print(error)
            }
        
        Alamofire.upload(fileURL, to: "http://192.168.169.84:3000/api/sf_integrations/upload_document").responseJSON
            { response in
            debugPrint(response)
        }
//        MCAWebServiceManager.sharedWebServiceManager.uploadImageRequest(requestParam:paramDict,
//                                                                  endPoint:MCAAPIEndPoints.BrokerUploadImageAPIEndpoint
//            , successCallBack:{ (response : JSON!) in
//                
//                self.stopActivityIndicator()
//             //   print("Success \(response)")
//                
//                
//        },
//              failureCallBack: { (error : Error) in
//                self.stopActivityIndicator()
//                print("Failure \(error)")
//                let alertViewController = UIAlertController(title : "MCAP", message : "Update Failed", preferredStyle : .alert)
//                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
//                self.present(alertViewController, animated: true , completion: nil)
//                
//        })

        profileImageButton.contentMode = .scaleAspectFit
        profileImageButton.setImage(profileImage, for: UIControlState.normal)
        dismiss(animated:true, completion: nil) 
    }
    


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
      
    @IBAction func updateProfileDetails()
    {
        
        self.showActivityIndicator()
        var paramDict  = Dictionary<String, String>()
        paramDict["contact_name"] = firstNameTF.text
        paramDict["contact_number"] = phoneNumberTF.text
        paramDict["image_url"] = ""

        
        
        
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
  
