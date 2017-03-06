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

    var dataSource = ["Funding Programs":"Stacy's Botique", "Contact":"Syndicate Premium", "Term":"18 Months", "Time in Buisness":"6 months", "Buy rate":"1.28%","Credit Score":"650","Minimum Loan": "$2000","Maximum Loan" : "$10,000"]
    var dataSourceArray : [String] = ["Funding Programs","Contact","Term","Time in Buisness","Buy rate","Credit Score","Minimum Loan","Maximum Loan"]
    var dataValueArray : [NSString] = ["Stacy's Botique","Helen","18 Months","6 months","1.28%","650","$2000","$10,000"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Stacy's Botique"
        tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationSummaryTVCell")
        tableView.tableFooterView = UIView()
        
        dataSourceArray = Array(dataSource.keys)


        // Do any additional setup after loading the view.
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
        cell.backgroundColor = UIColor.clear

        let title = dataSourceArray[indexPath.row]
        cell.titleLabel.text = title
        cell.dataTF.text = dataValueArray[indexPath.row] as String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  (indexPath.row == 1) {
            let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
            let underwritingMerchantVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPApplicationFormVC") as! MCAFPApplicationFormVC
            navigationController?.pushViewController(underwritingMerchantVC, animated: true)
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
