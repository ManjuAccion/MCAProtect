//
//  MCAFPApplicationDetailViewController.swift
//  MCAProtect
//
//  Created by Accion Labs on 20/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

enum ApplicationCatagories : NSInteger {
    case programInformation = 0
    case mearchantRequirement = 1
    case liensBankruptcy = 2
}

class MCAFPApplicationDetailVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!

    var programInformationArray : [String] = ["Program Information","Max Term","Minimum Loan Amount","Maximum Loan Amount","Buy rate","Max Up Sell Rate","Max % of Gross Revenue","Origination Fee","Loan Type","Installment Type","Accept Loan Position","Loan Agreement False"]
    
    var mearchantRequirementArray :[String] = ["Minimum Credit Score","Minimum Time in Business","Minimum Monthly Sales","Minimum Number of Bank Deposits(Avg)","Days with Negative Balance","Minimum Deposit Amount(Avg)","Minimum Daily Balance(Avg)"]
    
    var liensBankruptcyArray :[String] =
        ["Judgements/Liens Allowed","Number of Judgements/Liens Allowed","Max Liens/Judgements Amount","Is Bankruptcy Allowed?", "Can Merchant be in Payment Plan","Allowed Montly Payment", "Has Merchant Satisfied Bankruptcy?","When Discharged from Bankruptcy?"]
    
    var fieldCount : Int!
    var applicationModel : AnyObject!
    var programInformation : MCAFPProgramInformation!
    var merchantRequirement : MCAFPMerchantRquirement!
    var liensOrBankruptcy : MCAFPLiensOrBankruptcy!
    
    var dataSourceArray : [String] = []

    var categorySelected : NSInteger!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        programInformation = MCAFPProgramInformation(data: nil)
        merchantRequirement = MCAFPMerchantRquirement(data: nil)
        liensOrBankruptcy = MCAFPLiensOrBankruptcy(data: nil)

        
 tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationSummaryTVCell")

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(
        animated)
        switch categorySelected {
        case ApplicationCatagories.programInformation.rawValue:
            self.title = "Program Information"
            fieldCount = programInformation.fieldCount
            applicationModel = programInformation
        case ApplicationCatagories.mearchantRequirement.rawValue:
            self.title = "Mearchant Requirement"
            fieldCount = merchantRequirement.fieldCount
            applicationModel = merchantRequirement
        case ApplicationCatagories.liensBankruptcy.rawValue:
            self.title = "Liens/Bankrupt"
            fieldCount = liensOrBankruptcy.fieldCount
            applicationModel = liensOrBankruptcy
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fieldCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationSummaryTVCell", for: indexPath) as! MCAApplicationSummaryTVCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear

        
        switch categorySelected {
            
        case ApplicationCatagories.programInformation.rawValue:
            
            switch indexPath.row {
            case FPProgramInformationKeys.FPProgramInformation.hashValue:
                cell.setFPProgramInformation(programInfromation:applicationModel as! MCAFPProgramInformation, programInformationKeys:FPProgramInformationKeys.FPProgramInformation)
            case FPProgramInformationKeys.FPLoanAgreement.hashValue:
                cell.setFPProgramInformation(programInfromation:applicationModel as! MCAFPProgramInformation, programInformationKeys:FPProgramInformationKeys.FPLoanAgreement)
            case FPProgramInformationKeys.FPAcceptLoanPosition.hashValue:
                 cell.setFPProgramInformation(programInfromation:applicationModel as! MCAFPProgramInformation, programInformationKeys:FPProgramInformationKeys.FPAcceptLoanPosition)
            case FPProgramInformationKeys.FPInstallmentType.hashValue:
                cell.setFPProgramInformation(programInfromation:applicationModel as! MCAFPProgramInformation, programInformationKeys:FPProgramInformationKeys.FPInstallmentType)
            case FPProgramInformationKeys.FPOriginationFee.hashValue:
                 cell.setFPProgramInformation(programInfromation:applicationModel as! MCAFPProgramInformation, programInformationKeys:FPProgramInformationKeys.FPOriginationFee)
            case FPProgramInformationKeys.FPLoanType.hashValue:
                cell.setFPProgramInformation(programInfromation:applicationModel as! MCAFPProgramInformation, programInformationKeys:FPProgramInformationKeys.FPLoanType)
            case FPProgramInformationKeys.FPBuyRate.hashValue:
                cell.setFPProgramInformation(programInfromation:applicationModel as! MCAFPProgramInformation, programInformationKeys:FPProgramInformationKeys.FPBuyRate)
            case FPProgramInformationKeys.FPMaxTerm.hashValue:
                cell.setFPProgramInformation(programInfromation:applicationModel as! MCAFPProgramInformation, programInformationKeys:FPProgramInformationKeys.FPMaxTerm)
            case FPProgramInformationKeys.FPMaximumLoanAmount.hashValue:
                cell.setFPProgramInformation(programInfromation:applicationModel as! MCAFPProgramInformation, programInformationKeys:FPProgramInformationKeys.FPMaximumLoanAmount)
            case FPProgramInformationKeys.FPMinimumLoanAmount.hashValue:
                cell.setFPProgramInformation(programInfromation:applicationModel as! MCAFPProgramInformation, programInformationKeys:FPProgramInformationKeys.FPMinimumLoanAmount)
            case FPProgramInformationKeys.FPMaxGrossRevenue.hashValue:
                cell.setFPProgramInformation(programInfromation:applicationModel as! MCAFPProgramInformation, programInformationKeys:FPProgramInformationKeys.FPMaxGrossRevenue)
            case FPProgramInformationKeys.FPMaxUPSellRate.hashValue:
                cell.setFPProgramInformation(programInfromation:applicationModel as! MCAFPProgramInformation, programInformationKeys:FPProgramInformationKeys.FPMaxUPSellRate)

            default: break
            }
            
        case ApplicationCatagories.mearchantRequirement.rawValue:
            
            switch indexPath.row {
            case FPMerchantRequirementkeys.FPMinimumDailyBalance.hashValue:
                cell.setFPMerchantRequirement(merchantRequirement: applicationModel as! MCAFPMerchantRquirement, merchantRequirementKeys:
                FPMerchantRequirementkeys.FPMinimumDailyBalance)
                
            case FPMerchantRequirementkeys.FPMinimumDepositeAmount.hashValue:
                cell.setFPMerchantRequirement(merchantRequirement: applicationModel as! MCAFPMerchantRquirement, merchantRequirementKeys:
                    FPMerchantRequirementkeys.FPMinimumDepositeAmount)

            case FPMerchantRequirementkeys.FPDaysWithNegativeBalance.hashValue:
                cell.setFPMerchantRequirement(merchantRequirement: applicationModel as! MCAFPMerchantRquirement, merchantRequirementKeys:
                    FPMerchantRequirementkeys.FPDaysWithNegativeBalance)

            case FPMerchantRequirementkeys.FPMinimumNumOfBankDeposits.hashValue:
                cell.setFPMerchantRequirement(merchantRequirement: applicationModel as! MCAFPMerchantRquirement, merchantRequirementKeys:
                    FPMerchantRequirementkeys.FPMinimumNumOfBankDeposits)
                
            case FPMerchantRequirementkeys.FPMinimumCreditScore.hashValue:
                cell.setFPMerchantRequirement(merchantRequirement: applicationModel as! MCAFPMerchantRquirement, merchantRequirementKeys:
                    FPMerchantRequirementkeys.FPMinimumCreditScore)

            case FPMerchantRequirementkeys.FPMinimumMonthlySales.hashValue:
                cell.setFPMerchantRequirement(merchantRequirement: applicationModel as! MCAFPMerchantRquirement, merchantRequirementKeys:
                    FPMerchantRequirementkeys.FPMinimumMonthlySales)

            case FPMerchantRequirementkeys.FPMinimumTimeInBusiness.hashValue:
                cell.setFPMerchantRequirement(merchantRequirement: applicationModel as! MCAFPMerchantRquirement, merchantRequirementKeys:
                    FPMerchantRequirementkeys.FPMinimumTimeInBusiness)

           
            default: break
            }
        case ApplicationCatagories.liensBankruptcy.rawValue:
            switch indexPath.row {
            case FPLiensAndBankruptcyKeys.FPDischargedBankruptcy.hashValue:
                cell.setFPLiensBankruptcy(liensBankruptcyDetails: applicationModel as! MCAFPLiensOrBankruptcy, liensBankruptcyKeys: FPLiensAndBankruptcyKeys.FPDischargedBankruptcy)
            case FPLiensAndBankruptcyKeys.FPMerchantSatisfiedBankruptcy.hashValue:
                cell.setFPLiensBankruptcy(liensBankruptcyDetails: applicationModel as! MCAFPLiensOrBankruptcy, liensBankruptcyKeys: FPLiensAndBankruptcyKeys.FPMerchantSatisfiedBankruptcy)
            case FPLiensAndBankruptcyKeys.FPMontlyPaymentAllowed.hashValue:
                cell.setFPLiensBankruptcy(liensBankruptcyDetails: applicationModel as! MCAFPLiensOrBankruptcy, liensBankruptcyKeys: FPLiensAndBankruptcyKeys.FPMontlyPaymentAllowed)
            case FPLiensAndBankruptcyKeys.FPPaymentPlan.hashValue:
                cell.setFPLiensBankruptcy(liensBankruptcyDetails: applicationModel as! MCAFPLiensOrBankruptcy, liensBankruptcyKeys: FPLiensAndBankruptcyKeys.FPPaymentPlan)
            case FPLiensAndBankruptcyKeys.FPIsBankruptcyAllowed.hashValue:
                cell.setFPLiensBankruptcy(liensBankruptcyDetails: applicationModel as! MCAFPLiensOrBankruptcy, liensBankruptcyKeys: FPLiensAndBankruptcyKeys.FPIsBankruptcyAllowed)
            case FPLiensAndBankruptcyKeys.FPJudegementsORLiens.hashValue:
                cell.setFPLiensBankruptcy(liensBankruptcyDetails: applicationModel as! MCAFPLiensOrBankruptcy, liensBankruptcyKeys: FPLiensAndBankruptcyKeys.FPJudegementsORLiens)
            case FPLiensAndBankruptcyKeys.FPNumberOfJudementsOrLiens.hashValue:
                cell.setFPLiensBankruptcy(liensBankruptcyDetails: applicationModel as! MCAFPLiensOrBankruptcy, liensBankruptcyKeys: FPLiensAndBankruptcyKeys.FPNumberOfJudementsOrLiens)
            case FPLiensAndBankruptcyKeys.FPMaxLiensOrJudgementAmount.hashValue:
                cell.setFPLiensBankruptcy(liensBankruptcyDetails: applicationModel as! MCAFPLiensOrBankruptcy, liensBankruptcyKeys: FPLiensAndBankruptcyKeys.FPMaxLiensOrJudgementAmount)
                       default: break
            }
        default: break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
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
