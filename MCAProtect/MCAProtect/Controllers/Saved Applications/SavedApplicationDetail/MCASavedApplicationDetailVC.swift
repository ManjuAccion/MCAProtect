//
//  MCASavedApplicationDetailVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/28/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASavedApplicationDetailVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var applicaionDetailType: NSInteger!
    
    var loanDataSource = ["Business Name","Credit Score","Loan Amount","Loan Term","Need it By"]

    var businessInformationDataSource = ["Legal Business Name","Contact Name","Telephone","Email","Federal Tax ID","Gross Annual Sales","Business Entity Type","DBA Business Name","State of Incorporation","Business Start Date","Industry Type","Seasonal Business"]
    var businessAddressDataSource = ["Street","City","State","Zip Code","Web Address","Telephone","Fax Number"]
    
    var dataSourceArray : [String] = []
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell)
        tableView.tableFooterView = UIView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"iconEdit"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(editButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(
            animated)
        switch applicaionDetailType {
            
        case SavedApplicationForm.LoanDetails.rawValue:
            self.title = "Loan Details"
            dataSourceArray = loanDataSource
        case SavedApplicationForm.BusinessInformation.rawValue:
            self.title = "Business Information"
            dataSourceArray = businessInformationDataSource
        case SavedApplicationForm.BusinessAddress.rawValue:
            self.title = "Business Address"
            dataSourceArray = businessAddressDataSource
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
        cell.dataTF.text = dataSourceArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 68.0
    }
    
    func editButtonTapped() {
        
    }
    
}
