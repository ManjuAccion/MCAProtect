//
//  FundingProgramListViewController.swift
//  MCAProtect
//
//  Created by Accion Labs on 20/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFundingProgramListViewController: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField : UITextField!
    var fundingProgramList : MCAFundingProgramList!
    var FPListArray : NSMutableArray!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Funding Programs"
        FPListArray = NSMutableArray()
        
        for _ in 1...6
        {
            fundingProgramList = MCAFundingProgramList(Data:nil)
            FPListArray? .add(fundingProgramList)
        }
        tableView.register(UINib(nibName: "MCAApplicationTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationTVCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FPListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationTVCell", for: indexPath) as! MCAApplicationTVCell
         cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        fundingProgramList = FPListArray.object(at: indexPath.row) as! MCAFundingProgramList
        
        cell.dataSource(data: fundingProgramList)
        cell.rightButton.isHidden = false
        cell.emailButton.isHidden = true
        cell.phoneNumberButton.isHidden = true
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
         fundingSummaryVC.fundingProgramSummary = FPListArray.object(at: indexPath.row) as! MCAFundingProgramList
        navigationController?.pushViewController(fundingSummaryVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCAApplicationTVCell
        deselectedCell.selectedView.isHidden = true
        deselectedCell.backgroundColor = ColorConstants.background
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
