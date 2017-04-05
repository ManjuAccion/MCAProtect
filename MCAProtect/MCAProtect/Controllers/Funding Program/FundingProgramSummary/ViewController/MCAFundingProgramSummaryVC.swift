//
//  FundingProgramSummaryVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 20/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFundingProgramSummaryVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    
    var fundingProgramSummary : MCAFundingProgramList!
    
    var titleText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = fundingProgramSummary.fundingProgramName
        tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationSummaryTVCell")
        tableView.tableFooterView = UIView()
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fundingProgramSummary.fieldCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationSummaryTVCell", for: indexPath) as! MCAApplicationSummaryTVCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        switch indexPath.row {
        case FPApplicationSummaryKeys.FPSummaryFundingProgram.hashValue:
            cell.setFPSummaryDetails(FPSummary: fundingProgramSummary, key: FPApplicationSummaryKeys.FPSummaryFundingProgram)
        case FPApplicationSummaryKeys.FPSummaryContact.hashValue:
            cell.setFPSummaryDetails(FPSummary: fundingProgramSummary, key: FPApplicationSummaryKeys.FPSummaryContact)

        case FPApplicationSummaryKeys.FPSummaryTerm.hashValue:
            cell.setFPSummaryDetails(FPSummary: fundingProgramSummary, key: FPApplicationSummaryKeys.FPSummaryTerm)

        case FPApplicationSummaryKeys.FPSummaryTimeInBuisness.hashValue:
            cell.setFPSummaryDetails(FPSummary: fundingProgramSummary, key: FPApplicationSummaryKeys.FPSummaryTimeInBuisness)

        case FPApplicationSummaryKeys.FPSummaryBuyRate.hashValue:
            cell.setFPSummaryDetails(FPSummary: fundingProgramSummary, key: FPApplicationSummaryKeys.FPSummaryBuyRate)

        case FPApplicationSummaryKeys.FPSummaryCreditScore.hashValue:
            cell.setFPSummaryDetails(FPSummary: fundingProgramSummary, key: FPApplicationSummaryKeys.FPSummaryCreditScore)

        case FPApplicationSummaryKeys.FPSummaryMinimumLoan.hashValue:
            cell.setFPSummaryDetails(FPSummary: fundingProgramSummary, key: FPApplicationSummaryKeys.FPSummaryMinimumLoan)

        case FPApplicationSummaryKeys.FPSUmmaryMaximumLoan.hashValue:
            cell.setFPSummaryDetails(FPSummary: fundingProgramSummary, key: FPApplicationSummaryKeys.FPSUmmaryMaximumLoan)

        default:
            break
        }

    //    let title = dataSourceArray[indexPath.row]
    //    cell.titleLabel.text = title
     //   cell.dataTF.text = dataValueArray[indexPath.row] as String
        
        if  (indexPath.row == 0) {

        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  (indexPath.row == 0) {
            let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
            let applicationFormVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPApplicationFormVC") as! MCAFPApplicationFormVC
            applicationFormVC.fundingProgramList = fundingProgramSummary

            navigationController?.pushViewController(applicationFormVC, animated: true)
        }
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
