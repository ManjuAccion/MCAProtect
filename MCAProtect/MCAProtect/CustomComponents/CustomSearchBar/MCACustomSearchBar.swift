//
//  MCACustomSearchBar.swift
//  MCAProtect
//
//  Created by Manjunath on 12/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit


protocol MCACustomSearchBarDelegate {
    func searchTextDidBegin(inSearchString:String)
    func searchTextWillChangeWithString(inSearchString:String)
    func searchTextCleared()
    func searchTextDidEndWithString(inSearchString:String)
}

class MCACustomSearchBar: UIView,UITextFieldDelegate
{
    var searchTextField : UITextField!
    var delegate:MCACustomSearchBarDelegate?
    
    
    override func awakeFromNib() {
        searchTextField = UITextField(frame: CGRect.zero)
        self.addSubview(searchTextField)
        searchTextField.delegate = self;
    }
     func configureUI()
    {
        
//        let widthComponent = NSLayoutConstraint(item: searchTextField, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.95, constant: 0)
//
//        let heightComponent = NSLayoutConstraint(item: searchTextField, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.95, constant: 0)
//
//        let centerX = NSLayoutConstraint(item: searchTextField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 0.95, constant: 0)
//
//        let centerY = NSLayoutConstraint(item: searchTextField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.95, constant: 0)
//        
//        NSLayoutConstraint.activate([widthComponent,heightComponent,centerY,centerX])
//        
        
        
//        iconSearch
        
        
        let searchImage = UIImageView(frame: CGRect(x: 10, y: 9, width: 18, height: 18))
        
        searchImage.image = UIImage(named: "iconSearch")
        searchImage.contentMode = .scaleAspectFit
        
        
        self.searchTextField.delegate = self
        self.searchTextField.autocorrectionType = .no;
        self.searchTextField.leftView = searchImage;
        self.searchTextField.leftViewMode = .always;
        self.searchTextField.clearButtonMode = .whileEditing;
        self.searchTextField.placeholder = "Search here …"
        self.searchTextField.font = UIFont(name: "Roboto-Regular", size: 13.0)
        
        
        searchTextField.frame = CGRect(x: 5, y: 4, width: self.bounds.size.width-10, height: 36);
        searchTextField.backgroundColor = UIColor.white
        searchTextField.layer.cornerRadius = searchTextField.frame.size.height/2.0;
        print("\(searchTextField.frame)")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        delegate?.searchTextDidBegin(inSearchString: textField.text!)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        delegate?.searchTextCleared()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.searchTextWillChangeWithString(inSearchString: textField.text!.appending(string))
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        delegate?.searchTextDidEndWithString(inSearchString: textField.text!)
        return true
    }
}
