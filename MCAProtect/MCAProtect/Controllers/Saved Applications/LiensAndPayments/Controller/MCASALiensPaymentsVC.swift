//
//  MCASALiensPaymentsVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 01/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASALiensPaymentsVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    var loanApplication : MCALoanApplication!

    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- View Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Liens/Bankruptcy"
        
        tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCAApplicationSummaryTVCell)
        tableView.register(UINib(nibName: "MCALiensHeaderTableViewCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCALiensHeaderTableViewCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table view DataSource Methods -
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowsCount : Int!
        
        switch section {
            
            case LiensPayementsHeaderCell.judgementsOrLiens.rawValue:
                
                rowsCount = loanApplication.businessInfo.judgementsOrLiens == true ?  loanApplication.businessInfo.judgementsFieldCount :  0
            
            case LiensPayementsHeaderCell.payementPlan.rawValue:
                
                rowsCount = loanApplication.businessInfo.paymentPlan == true ?  loanApplication.businessInfo.payementFieldCount :  0
            
            case LiensPayementsHeaderCell.bankruptcy.rawValue:
                
                rowsCount = loanApplication.businessInfo.bankruptcy == true ?  loanApplication.businessInfo.bankruptcyFieldCount :  0
            
            default:break
        }
        
        return rowsCount
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = ColorConstants.background
        
        switch indexPath.section {
            
            case LiensPayementsHeaderCell.judgementsOrLiens.rawValue:
                
                switch indexPath.row {
                    
                    case JudgementsOrLiensKeys.numberOfJudgements.hashValue:
                            cell.setJudgementsInLiens(businessInfo: loanApplication.businessInfo, judgementsKey: JudgementsOrLiensKeys.numberOfJudgements)
                    case JudgementsOrLiensKeys.judgementOrLienAmount.hashValue:
                        cell.setJudgementsInLiens(businessInfo: loanApplication.businessInfo, judgementsKey: JudgementsOrLiensKeys.judgementOrLienAmount)
                    default:break
                    
                }
            case LiensPayementsHeaderCell.payementPlan.rawValue:
                
                switch indexPath.row {
                    
                    case PayementKeys.monthlyPaymentAmount.hashValue:
                        cell.setPaymentsInLiens(businessInfo: loanApplication.businessInfo, paymentKey: PayementKeys.monthlyPaymentAmount)
                    default:break
                }
            
            case LiensPayementsHeaderCell.bankruptcy.rawValue:
                
                switch indexPath.row {
                    
                    case BankruptcyKeys.bankruptcySatisfied.hashValue:
                        cell.setBankruptcyInLiens(businessInfo: loanApplication.businessInfo, bankruptcyKey: BankruptcyKeys.bankruptcySatisfied)
                    case BankruptcyKeys.dateOfDischarge.hashValue:
                        cell.setBankruptcyInLiens(businessInfo: loanApplication.businessInfo, bankruptcyKey: BankruptcyKeys.dateOfDischarge)
                    
                    default:break
                }
            
            default: break
        }
        
        return cell
        
    }
    
    //MARK: - Table View Delegate Methods-
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCALiensHeaderTableViewCell) as! MCALiensHeaderTableViewCell
        
        cell.setLiensHeader(businessInfo: loanApplication.businessInfo, index: section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return  60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view  = UIView.init(frame: CGRect(x:0, y:0,width: self.view.frame.size.width ,height:5))
        view.backgroundColor = ColorConstants.greyAlpha20
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }


}
