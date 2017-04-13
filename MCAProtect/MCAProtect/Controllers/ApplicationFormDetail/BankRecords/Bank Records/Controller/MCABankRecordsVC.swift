//
//  MCABankRecordsVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/1/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABankRecordsVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var applicationStatus : Int?
    var bankRecords : MCABankRecords!
    var bankRecordsArray : [MCABankRecords]!
    var loanApplication : MCALoanApplication!
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Bank Records"

        bankRecordsArray = loanApplication.businessFinance.bankRecords
        
        tableView.register(UINib(nibName: "MCABankRecordsTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCABankRecordsTVCell)
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankRecordsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCABankRecordsTVCell, for: indexPath) as! MCABankRecordsTVCell
        cell.selectionStyle = .none
        
        bankRecords = bankRecordsArray[indexPath.row]
        cell.setBankRecords(bankRecords: bankRecords)

        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCABankRecordsTVCell
        selectedCell.selectedView.isHidden = false
        selectedCell.backgroundColor = ColorConstants.selectedBackground
        
        let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
        let savedApplicationBankDetailsVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCABankDetailsVC) as! MCABankDetailsVC
        bankRecords = bankRecordsArray[indexPath.row]
        savedApplicationBankDetailsVC.applicationStatus = applicationStatus
        savedApplicationBankDetailsVC.bankRecord = bankRecords
        navigationController?.pushViewController(savedApplicationBankDetailsVC, animated: true)

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCABankRecordsTVCell
        deselectedCell.selectedView.isHidden = true
        deselectedCell.backgroundColor = ColorConstants.background
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75.0
    }
}
