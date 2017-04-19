//
//  MCALoansVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 02/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCALoansVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pastLoanStatusLabel: UILabel!
    @IBOutlet weak var pastLoanStatusImageView: UIImageView!
    @IBOutlet weak var existingLoanDetailsContainerView: UIView!
    @IBOutlet weak var existingLoanDetailsLabel: UILabel!
    var parentDelegate: MCAApplicationFormVC!
    
    var applicationStatus   : Int?
    var selectedIndexpath : IndexPath?

    var loanApplication     : MCALoanApplication!
    var mcaLoanAccountList  : [MCALoanAccountsList]!
    var loanAccountList     : MCALoanAccountsList!

    
    //MARK: - View Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MCA Loans"
        mcaLoanAccountList = loanApplication.businessFinance.mcaLoanAccountsList

        tableView.register(UINib(nibName: "MCALoansTVCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCALoansTVCell)
        tableView.tableFooterView = UIView()
        
        let pastMCALoanStatus = loanApplication.businessFinance.mcaLoanAccounts == true ? "YES" : "NO"
        
        if pastMCALoanStatus == "YES" {
            pastLoanStatusImageView.image = UIImage(named: "iconYesGreen")
            existingLoanDetailsLabel.isHidden = false
            tableView.isHidden = false
        }
        else {
            pastLoanStatusImageView.image = UIImage(named: "iconNoGreen")
            existingLoanDetailsLabel.isHidden = true
            tableView.isHidden = true
        }
        pastLoanStatusLabel.text = pastMCALoanStatus
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource methods -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mcaLoanAccountList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCALoansTVCell, for: indexPath) as! MCALoansTVCell
        
        loanAccountList = mcaLoanAccountList[indexPath.row]
        cell.setMCALoanApplication(mcaLoanApplication: loanAccountList)
        
        if let selectedIndexpath = selectedIndexpath, selectedIndexpath == indexPath{
            cell.selectedView.isHidden = false
            cell.backgroundColor = ColorConstants.selectedBackground
        }else{
            cell.selectedView.isHidden = true
        }
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedIndexpath != nil {
            let deselectedCell = tableView.cellForRow(at: selectedIndexpath! as IndexPath) as? MCALoansTVCell
            deselectedCell?.selectedView.isHidden = true
            deselectedCell?.backgroundColor = ColorConstants.background
            
        }
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCALoansTVCell
        selectedCell.selectedView.isHidden = false
        selectedCell.backgroundColor = ColorConstants.selectedBackground
        selectedIndexpath = indexPath

        
        let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
        let loanDetailsVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCALoanDetailVC) as! MCALoanDetailVC
        
        loanAccountList = mcaLoanAccountList[indexPath.row]
        loanDetailsVC.existingLoanDetail = loanAccountList
        loanDetailsVC.applicationStatus = applicationStatus

        navigationController?.pushViewController(loanDetailsVC, animated: true)
    }
    
    @IBAction func nextButton()
    {
        
        
        parentDelegate.goToNext()
    }
    
    @IBAction func previousButton()
    {
        
        parentDelegate.goToPrevious()
        
    }


}
