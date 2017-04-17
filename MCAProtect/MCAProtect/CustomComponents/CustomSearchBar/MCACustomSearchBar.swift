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
        
        
        
        let searchOverLay = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 18))
        let searchImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        searchOverLay.addSubview(searchImage);
        
        searchImage.frame = CGRect(x: 8, y: 0, width: 18, height: 18)
        searchImage.image = UIImage(named: "iconSearch")
        searchImage.contentMode = .scaleAspectFit
        searchOverLay.backgroundColor = UIColor.clear
        
        self.searchTextField.delegate = self
        self.searchTextField.autocorrectionType = .no;
        self.searchTextField.leftView = searchOverLay;
        self.searchTextField.leftViewMode = .always;
        self.searchTextField.clearButtonMode = .whileEditing;
        self.searchTextField.placeholder = "Search"
        self.searchTextField.font = UIFont(name: "Roboto-Regular", size: 13.0)
        
        
        searchTextField.frame = CGRect(x: 8, y: 8, width: self.bounds.size.width-16, height: 30);
        searchTextField.backgroundColor = UIColor.white
        searchTextField.layer.cornerRadius = searchTextField.frame.size.height/5.0;
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
        
        
        if string == "" {
            var searchStr = textField.text!
            searchStr.remove(at: searchStr.index(before: searchStr.endIndex))
            delegate?.searchTextWillChangeWithString(inSearchString: searchStr)
        }
        else
        {
            delegate?.searchTextWillChangeWithString(inSearchString: textField.text!.appending(string))
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        delegate?.searchTextDidEndWithString(inSearchString: textField.text!)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
