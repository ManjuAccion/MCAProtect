//
//  MCAApplicationFormVC
//  MCAProtect
//
//  Created by Sarath NS on 2/15/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAApplicationFormVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataDataSource = ["Loan Details","Business Information", "Business Address", "Liens/Payments/Bankruptcy", "Merchant Documentation", "Bank Records","MCA Loans","Owner/Officer Information","Business Location"]
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Stacty's Boutique                       "
        loadUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadUI() {
        
        tableView.register(UINib(nibName: "MCAApplicationStatusTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAApplicationStatusTVCell)
        tableView.register(UINib(nibName: "MCAApplicationFormTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAApplicationFormTVCell)
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.tableFooterView = UIView()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell :UITableViewCell!
        
        if indexPath.row == 0 {
            let statusTVCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationStatusTVCell, for: indexPath) as! MCAApplicationStatusTVCell
            statusTVCell.statusLabel.text = "Progress"
            cell = statusTVCell
        }
        else {
            let applicationFormCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationFormTVCell, for: indexPath) as! MCAApplicationFormTVCell
            applicationFormCell.titleLabel.text = dataDataSource[indexPath.row - 1]
            cell = applicationFormCell
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCAApplicationFormTVCell
            selectedCell.selectedView.isHidden = false
            
            switch indexPath.row {
            case SavedApplicationForm.LoanDetails.rawValue:
                let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
                let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCASavedApplicationDetailVC) as! MCASavedApplicationDetailVC
                navigationController?.pushViewController(savedApplicationDetailVC, animated: true)
                savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.LoanDetails.rawValue
            case SavedApplicationForm.BusinessInformation.rawValue:
                let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
                let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCASavedApplicationDetailVC) as! MCASavedApplicationDetailVC
                navigationController?.pushViewController(savedApplicationDetailVC, animated: true)
                savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.BusinessInformation.rawValue
            case SavedApplicationForm.BusinessAddress.rawValue:
                let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
                let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCASavedApplicationDetailVC) as! MCASavedApplicationDetailVC
                navigationController?.pushViewController(savedApplicationDetailVC, animated: true)
                savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.BusinessAddress.rawValue
            case SavedApplicationForm.LiensOrPaymentsOrBankruptcy.rawValue:
                print("Inside LiensOrPaymentsOrBankruptcy")
            case SavedApplicationForm.MerchantDocumentation.rawValue:
                let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
                let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCASavedApplicationMerchantDocumentationVC) as! MCASavedApplicationMerchantDocumentationVC
                navigationController?.pushViewController(savedApplicationDetailVC, animated: true)
                
            case SavedApplicationForm.BankRecords.rawValue:
                print("Inside BankRecords")
            case SavedApplicationForm.MCALoans.rawValue:
                print("Inside MCALoans")
            case SavedApplicationForm.OwnerOrOfficerInformation.rawValue:
                print("Inside OwnerOrOfficerInformation")
            case SavedApplicationForm.BusinessLocation.rawValue:
                print("Inside BusinessLocation")

            default:
                print("Inside Default")

            }
        }
    }
    
    func loadSavedApplicationDetailVC() {

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            let deselectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCAApplicationFormTVCell
            deselectedCell.selectedView.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }

    
    
}
