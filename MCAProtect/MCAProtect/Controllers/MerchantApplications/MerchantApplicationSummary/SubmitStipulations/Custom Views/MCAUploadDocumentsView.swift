//
//  MCAUploadDocumentsView.swift
//  MCAProtect
//
//  Created by Sarath Neeravallil on 25/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

protocol MCAUploadDocumentsViewDelegate {
    
    func cameraButtonTapped()
    func uploadButtonTapped(documentName: String)
}

class MCAUploadDocumentsView: UIView,UITextFieldDelegate {
    
    
    @IBOutlet weak var documentNameTF: UITextField!
    @IBOutlet weak var uploadDocumentButton: UIButton!
    @IBOutlet weak var overlayView: MCARoundedOverlayView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        let myColor : UIColor = UIColor.black
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = myColor.cgColor
        imageView.layer.cornerRadius = 5.0
    }
    
    
    var delegate : MCAUploadDocumentsViewDelegate?
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        
        delegate?.cameraButtonTapped()
    }

    @IBAction func uploadDocumentButtonTapped(_ sender: Any) {
        delegate?.uploadButtonTapped(documentName:documentNameTF.text!)
    }
    
    //MARK: - TextField Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }

}
