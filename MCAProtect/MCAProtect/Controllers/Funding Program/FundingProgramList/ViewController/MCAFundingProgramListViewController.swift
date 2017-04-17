//
//  FundingProgramListViewController.swift
//  MCAProtect
//
//  Created by Accion Labs on 20/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON



class MCAFundingProgramListViewController: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField : UITextField!
    var fundingProgram : MCAFundingProgram!
    var fundingProgramList : NSMutableArray!
    var pageCount : Int!
    

    //MARK: - View Life Cycle - 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Funding Programs", comment: "")
        fundingProgramList = NSMutableArray()
       
        getFundingProgramList()
        
        tableView.register(UINib(nibName: "MCAApplicationTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAApplicationTVCell)
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    func getFundingProgramList()
    {
        
        self.showActivityIndicator()
        
        var paramDict = Dictionary<String, String>()
        paramDict["page"] = "1"
        paramDict["per_page"] = pageSize

        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:paramDict,
                                                                endPoint:MCAAPIEndPoints.BrokerFunderProgramListEndpoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()

                let fundingProgramArray = response.arrayValue
                
                    for item in fundingProgramArray {
                        self.fundingProgram = MCAFundingProgram(data:item)
                        self.fundingProgramList.add(self.fundingProgram)
                    }
                    self.tableView.reloadData()
                
        },
              failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Unable to fetch Funding Programs", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
 
        
        
    }
    

    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fundingProgramList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationTVCell", for: indexPath) as! MCAApplicationTVCell
         cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
       let   fundingPgram = fundingProgramList.object(at: indexPath.row) as! MCAFundingProgram
        
        cell.dataSource(data: fundingPgram)
        cell.rightButton.isHidden = false
        cell.emailButton.isHidden = true
        cell.phoneNumberButton.isHidden = true
        cell.rightButton .setImage(UIImage(named : "iconCheckRound"), for: UIControlState.normal)
        
        cell.delegate = self;
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if nil != fundingProgram {
            fundingProgram.isSelected = false
        }

        let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
        let fundingSummaryVC = storyBoard.instantiateViewController(withIdentifier: "FundingProgramSummaryVC") as! MCAFundingProgramSummaryVC
        fundingProgram = fundingProgramList.object(at: indexPath.row) as! MCAFundingProgram
        fundingProgram.isSelected = true
         fundingSummaryVC.fundingProgramSummary = fundingProgramList.object(at: indexPath.row) as! MCAFundingProgram
        tableView.reloadData()

        navigationController?.pushViewController(fundingSummaryVC, animated: true)
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
