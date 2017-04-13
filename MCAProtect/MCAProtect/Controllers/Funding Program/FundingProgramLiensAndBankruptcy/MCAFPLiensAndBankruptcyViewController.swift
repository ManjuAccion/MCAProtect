//
//  MCAFPLiensAndBankruptcyViewController.swift
//  MCAProtect
//
//  Created by Accion Labs on 06/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFPLiensAndBankruptcyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    var fundingProgram : MCAFundingProgram!
    var liensOrBankruptcy : MCAFPLiensOrBankruptcy!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        

         tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCAApplicationSummaryTVCell)
        tableView.register(UINib(nibName: "MCALiensHeaderTableViewCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCALiensHeaderTableViewCell)
        
        liensOrBankruptcy = fundingProgram.FPLiensOrBankruptcy

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
        
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        /*
        switch indexPath.section {

        
        case LiensPayementsHeaderCell.judgementsOrLiens.rawValue:
            
            switch indexPath.row {
                
            case JudgementsOrLiensKeys.numberOfJudgements.hashValue:
                cell.setFPLiensBankruptcy(liensBankruptcyDetails: liensOrBankruptcy , liensBankruptcyKeys: FPLiensAndBankruptcyKeys.FPDischargedBankruptcy)
            case JudgementsOrLiensKeys.judgementOrLienAmount.hashValue:
                cell.setFPLiensBankruptcy(liensBankruptcyDetails: liensOrBankruptcy, liensBankruptcyKeys: FPLiensAndBankruptcyKeys.FPDischargedBankruptcy)
            default:break
                
            }
        case LiensPayementsHeaderCell.payementPlan.rawValue:
            
            switch indexPath.row {
                
            case PayementKeys.monthlyPaymentAmount.hashValue:
                cell.setFPLiensBankruptcy(liensBankruptcyDetails: liensOrBankruptcy, liensBankruptcyKeys: FPLiensAndBankruptcyKeys.FPMontlyPaymentAllowed)
            default:break
            }
            
        case LiensPayementsHeaderCell.bankruptcy.rawValue:
            
            switch indexPath.row {
                
            case BankruptcyKeys.bankruptcySatisfied.hashValue:
                cell.setFPLiensBankruptcy(liensBankruptcyDetails: liensOrBankruptcy, liensBankruptcyKeys: FPLiensAndBankruptcyKeys.FPIsBankruptcyAllowed)
            case BankruptcyKeys.dateOfDischarge.hashValue:
                cell.setFPLiensBankruptcy(liensBankruptcyDetails: liensOrBankruptcy, liensBankruptcyKeys: FPLiensAndBankruptcyKeys.FPJudegementsORLiens)
                
            default:break
            }
            
        default: break
        }
*/
        return cell
    
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCALiensHeaderTableViewCell) as! MCALiensHeaderTableViewCell
        
        cell.setLiensHeader(fpLiensOrBankruptcy : liensOrBankruptcy, index: section)

        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
