//
//  MCABankRecordsVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/1/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASavedApplicationsBankRecordsVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {

    
    //MARK: - View Life Cycle
    
    var bankNameArray = ["Bank of America","Dag Bank","JPMorgan Chase","Wells Fargo"]
    var accountNumberArray  = ["BOA546897236","DB1234567890","123JP445545","2346474747464"]
    var accountBalanceArray = ["$3,300","$2,200","$2,350","$2,456","$4,568"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bank Records"
//        tableView.register(UINib(nibName: "MCASavedApplicationsBankRecordsTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCASavedApplicationsBankRecordsTVCell)
//        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCASavedApplicationsBankRecordsTVCell, for: indexPath) as! MCASavedApplicationsBankRecordsTVCell
        cell.selectionStyle = .none
        
        cell.bankNameLabel.text = bankNameArray[indexPath.row]
        cell.accountNumberLabel.text = accountNumberArray[indexPath.row]
        cell.amountLabel.text = accountBalanceArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCASavedApplicationsBankRecordsTVCell
        selectedCell.selectedView.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCASavedApplicationsBankRecordsTVCell
        deselectedCell.selectedView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75.0
    }
    

 
}
