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
    
    var dataSourceArray : [String] = []

    var categorySelected : NSInteger!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationSummaryTVCell")

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(
        animated)
        switch categorySelected {
        case ApplicationCatagories.programInformation.rawValue:
            self.title = "Program Information"
            dataSourceArray = programInformationArray
        case ApplicationCatagories.mearchantRequirement.rawValue:
            self.title = "Mearchant Requirement"
            dataSourceArray = mearchantRequirementArray
        case ApplicationCatagories.liensBankruptcy.rawValue:
            self.title = "Liens/Bankrupt"
            dataSourceArray = liensBankruptcyArray
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
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationSummaryTVCell", for: indexPath) as! MCAApplicationSummaryTVCell
        cell.selectionStyle = .none
        let title = dataSourceArray[indexPath.row]
        cell.titleLabel.text = title
   
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 68.0
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
