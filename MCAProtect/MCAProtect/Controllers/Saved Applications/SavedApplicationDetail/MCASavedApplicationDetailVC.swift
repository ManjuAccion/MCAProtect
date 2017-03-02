//
//  MCASavedApplicationDetailVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/28/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASavedApplicationDetailVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var applicaionDetailType: NSInteger!
    var isViewingMode : Bool?
    var summaryTVCell : MCAApplicationSummaryTVCell?
    var activeField: UITextField?
    var toolBar : UIToolbar?
    var doneButton : UIBarButtonItem?
    
    var loanDataSource = ["Business Name","Credit Score","Loan Amount","Loan Term","Need it By"]
    var loanDataSourceValue = ["Stacy's Boutique","552","$75,000","6 Months","5 Days"]

    var businessInformationDataSource = ["Legal Business Name","Contact Name","Telephone","Email","Federal Tax ID","Gross Annual Sales","Business Entity Type","DBA Business Name","State of Incorporation","Business Start Date","Industry Type","Seasonal Business"]
    var businessInformationDataSourceValue = ["Stacy's Boutique","Helen Parker","(876) 965-8756","helen.parker@gmail.com","8768968","$30,000","Partnership","Stacy's Boutique","California","2014-12-09","Ice Creanm","Yes"]
    var businessAddressDataSource = ["Street","City","State","Zip Code","Web Address","Telephone","Fax Number"]
    var businessAddressDataSourceValue = ["E 76th PI","Los Angeles","California","780098","www.stacysboutique.com","(976) 745-3435","(976) 745-3435"]
    
    var dataSourceArray : [String] = []
    var dataSourceValueArray : [String] = []

    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell)
        tableView.tableFooterView = UIView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"iconEdit"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(editButtonTapped))
        isViewingMode = true
        initializeToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(
            animated)
        registerForKeyboardNotifications()
        switch applicaionDetailType {
            
        case SavedApplicationForm.LoanDetails.rawValue:
            self.title = "Loan Details"
            dataSourceArray = loanDataSource
            dataSourceValueArray = loanDataSourceValue
            
        case SavedApplicationForm.BusinessInformation.rawValue:
            self.title = "Business Information"
            dataSourceArray = businessInformationDataSource
            dataSourceValueArray = businessInformationDataSourceValue

        case SavedApplicationForm.BusinessAddress.rawValue:
            self.title = "Business Address"
            dataSourceArray = businessAddressDataSource
            dataSourceValueArray = businessAddressDataSourceValue

        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        cell.titleLabel.text = dataSourceArray[indexPath.row]
        cell.dataTF.text = dataSourceValueArray[indexPath.row]
        cell.dataTF.delegate = self
        cell.dataTF.isUserInteractionEnabled = true
//        cell.dataTF.tag = indexPath.row
        
        return cell
    }
    
    //MARK: - Table View Delegate
    
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
//        activeField?.inputAccessoryView = toolBar
//        
//        if textField.tag == dataSourceArray.count - 1 {
//            doneButton?.title = "Done"
//        }
//        else{
//            doneButton?.title = "Next"
//        }
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
    
    func initializeToolBar() {
        toolBar = UIToolbar()
        toolBar?.barStyle = .blackTranslucent
        toolBar?.isTranslucent = true
        toolBar?.sizeToFit()
        
        doneButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.inputToolbarDonePressed))
        doneButton?.tintColor = .white
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar?.setItems([flexibleSpaceButton, doneButton!], animated: false)
        toolBar?.isUserInteractionEnabled = true
        
    }
    
    func inputToolbarDonePressed() {
        let nextResponder = activeField?.superview?.superview?.superview?.viewWithTag((activeField?.tag)! + 1) as UIResponder!
        if (nextResponder != nil) {
            nextResponder?.becomeFirstResponder()
        }
        else {
            activeField?.resignFirstResponder()
        }
    }
}
