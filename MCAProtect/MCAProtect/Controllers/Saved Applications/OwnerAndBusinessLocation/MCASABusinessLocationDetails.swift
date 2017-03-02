//
//  MCASABusinessLocationDetails.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/1/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASABusinessLocationDetails: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var isViewingMode : Bool?
    var activeField: UITextField?
    var businessLocationName: String?

    //MARK: - View Life Cycle
    
    let businessLocationArray = ["Location Type","Monthly Payement","Street Address","City","State","Zip Code","Home Phone","% Owned"]
    let businessLocationValueArray  = ["Mortgaged","$1,200","E 12 Deming PL","Star City","Alabama","12345","(801) 459-2206","50%"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell)
        tableView.tableFooterView = UIView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"iconEdit"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(editButtonTapped))
        self.title = businessLocationName
        isViewingMode = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessLocationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
        cell.selectionStyle = .none
        
        cell.titleLabel.text = businessLocationArray[indexPath.row]
        cell.dataTF.text = businessLocationValueArray[indexPath.row]
        
        cell.dataTF.delegate = self
        cell.dataTF.isUserInteractionEnabled = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    //MARK: - TextField Delegate Functions
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return !isViewingMode!
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        activeField?.resignFirstResponder()
        return true
    }
    
    
    //MARK: - Keyboard Functions
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(aNotification: NSNotification) {
        var userInfo = aNotification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = tableView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        tableView.contentInset = contentInset
    }
    
    func keyboardWillBeHidden(aNotification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets(top: 60.0,left: 0,bottom: 0,right: 0);
        tableView.contentInset = contentInset
    }
    
    //MARK: - Custom Functions
    
    
    func editButtonTapped() {
        
        if isViewingMode == false {
            
            isViewingMode = true
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            self.view.endEditing(true)
            
            var image = UIImage(named: "iconEdit")
            image = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(editButtonTapped))
            
        }
        else {
            
            isViewingMode = false
            tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            
            var image = UIImage(named: "editIconCheck")
            image = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(editButtonTapped))
        }
    }

}
