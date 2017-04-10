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
    @IBOutlet weak var billingAddressCheckButton: UIButton!
    @IBOutlet weak var tableViewBottomConstraint:NSLayoutConstraint!
    @IBOutlet weak var billingAddressContainerView: UIView!
    
    var applicaionDetailType    : NSInteger!
    var isViewingMode           : Bool?
    var summaryTVCell           : MCAApplicationSummaryTVCell?
    var activeField             : UITextField?
    var toolBar                 : UIToolbar?
    var doneButton              : UIBarButtonItem?
    var applicationStatus       : Int?
    var fieldCount              : Int!
    var applicationModel        : AnyObject!
    var dataSourceArray         : [String] = []
    var dataSourceValueArray    : [String] = []
    var selectedLoanApp         : MCALoanApplication!

    //MARK: - View Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell)
        tableView.register(UINib(nibName: "MCAPhoneNumberTableViewCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCAPhoneNumberTableViewCell)
        tableView.register(UINib(nibName: "MCAEmailTableViewCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCAEmailTableViewCell)

        isViewingMode = true
        initializeToolBar()

        if applicationStatus == ApplicationStatus.CopyApplication.rawValue || applicationStatus == ApplicationStatus.ResumeApplication.rawValue {
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"iconEdit"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(editButtonTapped))
        }
        if  applicaionDetailType == SavedApplicationForm.BusinessAddress.rawValue {
            let billingAddressContainerViewTapGesture = UITapGestureRecognizer(target: self, action:#selector(handlebillingAddressContainerViewTapGesture))
            billingAddressContainerView.addGestureRecognizer(billingAddressContainerViewTapGesture)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(
            animated)
        registerForKeyboardNotifications()
        switch applicaionDetailType {
            
            case SavedApplicationForm.LoanDetails.rawValue:
                self.title = "Loan Details"
                fieldCount = selectedLoanApp.programInfo.loanDetailFieldCount
                self.tableViewBottomConstraint.constant = 0.0
                
            case SavedApplicationForm.BusinessInformation.rawValue:
                self.title = "Business Information"
                fieldCount = selectedLoanApp.businessInfo.fieldCount
                self.tableViewBottomConstraint.constant = 0.0

            case SavedApplicationForm.BusinessAddress.rawValue:
                self.title = "Business Address"
                fieldCount = selectedLoanApp.address.addressFieldCount

            default:
                break
        }
        
        let contentInset:UIEdgeInsets = UIEdgeInsets(top: 60.0,left: 0,bottom: 0,right: 0);
        tableView.contentInset = contentInset
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func billingAddressButtonTapped(_ sender: Any) {
        
        if billingAddressCheckButton.isSelected == true {
            
            billingAddressCheckButton.setImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
            billingAddressCheckButton.isSelected = false;
        }
        else {
            
            billingAddressCheckButton.setImage(UIImage(named: "icon_checked"), for: UIControlState.normal)
            billingAddressCheckButton.isSelected = true;
        }
    }
    
    
    //MARK: - Table View Datasource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fieldCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        switch applicaionDetailType {
            
            case SavedApplicationForm.LoanDetails.rawValue:
                
                switch indexPath.row {
                    case LoanDetailKeys.businessName.hashValue:
                        cell.setLoanDetail(programInformation: selectedLoanApp.programInfo, loanKey: LoanDetailKeys.businessName)
                    case LoanDetailKeys.creditScore.hashValue:
                        cell.setLoanDetail(programInformation: selectedLoanApp.programInfo, loanKey: LoanDetailKeys.creditScore)
                    case LoanDetailKeys.loanAmount.hashValue:
                        cell.setLoanDetail(programInformation: selectedLoanApp.programInfo, loanKey: LoanDetailKeys.loanAmount)
                    case LoanDetailKeys.loanTerm.hashValue:
                        cell.setLoanDetail(programInformation: selectedLoanApp.programInfo, loanKey: LoanDetailKeys.loanTerm)
                    case LoanDetailKeys.needItBy.hashValue:
                        cell.setLoanDetail(programInformation: selectedLoanApp.programInfo, loanKey: LoanDetailKeys.needItBy)
                    default: break
                }

            case SavedApplicationForm.BusinessInformation.rawValue:
            
                switch indexPath.row {
                    case BusinessInformationKeys.legalBusinessName.hashValue:
                        cell.setBusinessInformation(businessInformation: selectedLoanApp.businessInfo, businessInfoKey: BusinessInformationKeys.legalBusinessName)
                    case BusinessInformationKeys.contactName.hashValue:
                        cell.setBusinessInformation(businessInformation: selectedLoanApp.businessInfo, businessInfoKey: BusinessInformationKeys.contactName)
                    case BusinessInformationKeys.telephone.hashValue:
                        
                        let   phoneNumberCell =   tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAPhoneNumberTableViewCell, for: indexPath) as! MCAPhoneNumberTableViewCell
                        phoneNumberCell.setBusinessInformation(businessInformation: selectedLoanApp.businessInfo, businessInfoKey: BusinessInformationKeys.telephone)
                        phoneNumberCell.delegate = self
                        phoneNumberCell.selectionStyle = .none
                        phoneNumberCell.backgroundColor = UIColor.clear

                    case BusinessInformationKeys.email.hashValue:
                        
                        let   emailCell =   tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAEmailTableViewCell, for: indexPath) as! MCAEmailTableViewCell
                        emailCell.delegate = self
                        emailCell.selectionStyle = .none
                        emailCell.backgroundColor = UIColor.clear
                        emailCell.setBusinessInformation(businessInformation: selectedLoanApp.businessInfo, businessInfoKey: BusinessInformationKeys.email)
                    case BusinessInformationKeys.federalTaxID.hashValue:
                        cell.setBusinessInformation(businessInformation: selectedLoanApp.businessInfo, businessInfoKey: BusinessInformationKeys.federalTaxID)
                    case BusinessInformationKeys.grossAnnualSales.hashValue:
                        cell.setBusinessInformation(businessInformation: selectedLoanApp.businessInfo, businessInfoKey: BusinessInformationKeys.grossAnnualSales)
                    case BusinessInformationKeys.grossAnnualRevenue.hashValue:
                        cell.setBusinessInformation(businessInformation: selectedLoanApp.businessInfo, businessInfoKey: BusinessInformationKeys.grossAnnualRevenue)
                    case BusinessInformationKeys.businessEntityType.hashValue:
                        cell.setBusinessInformation(businessInformation: selectedLoanApp.businessInfo, businessInfoKey: BusinessInformationKeys.businessEntityType)
                    case BusinessInformationKeys.dBABusinessName.hashValue:
                        cell.setBusinessInformation(businessInformation: selectedLoanApp.businessInfo, businessInfoKey: BusinessInformationKeys.dBABusinessName)
                    case BusinessInformationKeys.stateOfIncorprataion.hashValue:
                        cell.setBusinessInformation(businessInformation: selectedLoanApp.businessInfo, businessInfoKey: BusinessInformationKeys.stateOfIncorprataion)
                    case BusinessInformationKeys.businessStartDate.hashValue:
                        cell.setBusinessInformation(businessInformation: selectedLoanApp.businessInfo, businessInfoKey: BusinessInformationKeys.businessStartDate)
                    case BusinessInformationKeys.industryType.hashValue:
                        cell.setBusinessInformation(businessInformation: selectedLoanApp.businessInfo, businessInfoKey: BusinessInformationKeys.industryType)
                    case BusinessInformationKeys.seasonalBusiness.hashValue:
                        cell.setBusinessInformation(businessInformation: selectedLoanApp.businessInfo, businessInfoKey: BusinessInformationKeys.seasonalBusiness)
                    default: break
                }
            case SavedApplicationForm.BusinessAddress.rawValue:
                switch indexPath.row {
                    case BusinessAddressKeys.street.hashValue:
                        cell.setBusinessAddress(businessAddress: selectedLoanApp.address, businessAddressKey: BusinessAddressKeys.street)
                    case BusinessAddressKeys.city.hashValue:
                        cell.setBusinessAddress(businessAddress: selectedLoanApp.address, businessAddressKey: BusinessAddressKeys.city)
                    case BusinessAddressKeys.state.hashValue:
                        cell.setBusinessAddress(businessAddress: selectedLoanApp.address, businessAddressKey: BusinessAddressKeys.state)
                    case BusinessAddressKeys.zipCode.hashValue:
                        cell.setBusinessAddress(businessAddress: selectedLoanApp.address, businessAddressKey: BusinessAddressKeys.zipCode)
                    case BusinessAddressKeys.webAddress.hashValue:
                        cell.setBusinessAddress(businessAddress: selectedLoanApp.address, businessAddressKey: BusinessAddressKeys.webAddress)
                    case BusinessAddressKeys.telephone.hashValue:
                        let   phoneNumberCell =   tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAPhoneNumberTableViewCell, for: indexPath) as! MCAPhoneNumberTableViewCell
                        phoneNumberCell.setBusinessAddress(businessAddress: selectedLoanApp.address, businessAddressKey: BusinessAddressKeys.telephone)
                        phoneNumberCell.delegate = self
                        phoneNumberCell.selectionStyle = .none
                        phoneNumberCell.backgroundColor = UIColor.clear
                    case BusinessAddressKeys.faxNumber.hashValue:
                        let   phoneNumberCell =   tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAPhoneNumberTableViewCell, for: indexPath) as! MCAPhoneNumberTableViewCell
                        phoneNumberCell.setBusinessAddress(businessAddress: selectedLoanApp.address, businessAddressKey:  BusinessAddressKeys.faxNumber)
                        phoneNumberCell.delegate = self
                        phoneNumberCell.selectionStyle = .none
                        phoneNumberCell.backgroundColor = UIColor.clear

                    default: break
                    }
            default: break
            }
        
        cell.dataTF.delegate = self
        cell.dataTF.isUserInteractionEnabled = true
        
        return cell
    }
    
    //MARK: - Table View Delegate -
    
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

    //MARK: - Keyboard Functions -
    
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
    
    
    //MARK: - Custom Functions -
    
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
    
    func handlebillingAddressContainerViewTapGesture() {
        if billingAddressCheckButton.isSelected == true {
            
            billingAddressCheckButton.setImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
            billingAddressCheckButton.isSelected = false;
        }
        else {
            
            billingAddressCheckButton.setImage(UIImage(named: "icon_checked"), for: UIControlState.normal)
            billingAddressCheckButton.isSelected = true;
        }
    }
}
