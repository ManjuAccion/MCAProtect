//
//  MCABankRecordsVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/1/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASavedApplicationsBankRecordsVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var applicationStatus : Int?
    var bankRecords : MCABankRecords!
    var bankRecordsArray : [MCABankRecords]!
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Bank Records"

        bankRecordsArray = [MCABankRecords]()
        for _ in 1...6
        {
            bankRecords = MCABankRecords(data:nil)
            bankRecordsArray.append(bankRecords)
        }
        
        tableView.register(UINib(nibName: "MCASavedApplicationsBankRecordsTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCASavedApplicationsBankRecordsTVCell)
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankRecords.bankRecordsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCASavedApplicationsBankRecordsTVCell, for: indexPath) as! MCASavedApplicationsBankRecordsTVCell
        cell.selectionStyle = .none
        
        bankRecords = bankRecordsArray[indexPath.row]
        cell.setBankRecords(bankRecords: bankRecords)

        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCASavedApplicationsBankRecordsTVCell
        selectedCell.selectedView.isHidden = false
        selectedCell.backgroundColor = ColorConstants.selectedBackground
        
        let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
        let savedApplicationBankDetailsVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCASavedApplicationBankDetailsVC) as! MCASavedApplicationBankDetailsVC
        bankRecords = bankRecordsArray[indexPath.row]
        savedApplicationBankDetailsVC.bankName = bankRecords.bankName
        savedApplicationBankDetailsVC.applicationStatus = applicationStatus
        navigationController?.pushViewController(savedApplicationBankDetailsVC, animated: true)

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCASavedApplicationsBankRecordsTVCell
        deselectedCell.selectedView.isHidden = true
        deselectedCell.backgroundColor = ColorConstants.background
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75.0
    }
}
