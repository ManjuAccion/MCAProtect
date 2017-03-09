//
//  FundingProgramListViewController.swift
//  MCAProtect
//
//  Created by Accion Labs on 20/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFundingProgramListViewController: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var dataDataSource = ["The Jewellery Shop", "Stacy's Boutique", "Miami Florists", "Food Truck", "Sport's World"]
    var amountDataSource = ["$2000","$3000","$4000","$5000","$6000"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Funding Programs"
        
        tableView.register(UINib(nibName: "MCAApplicationTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationTVCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationTVCell", for: indexPath) as! MCAApplicationTVCell
         cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.headingLabel.text = dataDataSource[indexPath.row]
        cell.detailLabel.text = amountDataSource[indexPath.row]
        cell.rightButton.isHidden = false
        cell.rightButton .setImage(UIImage(named : "iconCheckRound"), for: UIControlState.normal)
        
        cell.delegate = self;
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCAApplicationTVCell
        selectedCell.selectedView.isHidden = false
        selectedCell.backgroundColor = ColorConstants.selectedBackground
        let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
        let fundingSummaryVC = storyBoard.instantiateViewController(withIdentifier: "FundingProgramSummaryVC") as! MCAFundingProgramSummaryVC
        fundingSummaryVC.titleText = dataDataSource[indexPath.row]
        navigationController?.pushViewController(fundingSummaryVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCAApplicationTVCell
        deselectedCell.selectedView.isHidden = true
        deselectedCell.backgroundColor = ColorConstants.background
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80.0
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
