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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(
            animated)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
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

            var image = UIImage(named: "iconCheck")
            image = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(editButtonTapped))
        }

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return !isViewingMode!
    }
    

    
}
