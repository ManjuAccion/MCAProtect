//
//  FundingProgramListViewController.swift
//  MCAProtect
//
//  Created by Accion Labs on 20/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON



class MCAFundingProgramListViewController: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MCACustomSearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var seacrhBar : MCACustomSearchBar!
    var fundingProgram : MCAFundingProgram!
    var fundingProgramList = [MCAFundingProgram]()
    var filteredFundingProgramList = [MCAFundingProgram]()
    var displayList = [MCAFundingProgram]()
    var pageCount : Int!
    

    //MARK: - View Life Cycle - 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Funding Programs", comment: "")
        pageCount = 0;
        getFundingProgramList()
        
        tableView.register(UINib(nibName: "MCAApplicationTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAApplicationTVCell)
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        seacrhBar.delegate = self
        seacrhBar.configureUI()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    func getFundingProgramList()
    {
        if self.checkNetworkConnection() == false {
            return
        }
        
        self.showActivityIndicator()

        
        var paramDict = Dictionary<String, String>()
        
        paramDict["page"] = "\(pageCount + 1)"
        paramDict["per_page"] = pageSize
        pageCount = pageCount + 1
        
        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:paramDict,
                                                                endPoint:MCAAPIEndPoints.BrokerFunderProgramListEndpoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()
                
                let fundingProgramArray = response.arrayValue
                
                for item in fundingProgramArray {
                    self.fundingProgram = MCAFundingProgram(data:item)
                    self.fundingProgramList.append(self.fundingProgram)
                }
                self.displayList = self.fundingProgramList;
                
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
        return displayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationTVCell", for: indexPath) as! MCAApplicationTVCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        let fundingPgram = displayList[indexPath.row]
        
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
        fundingProgram = displayList[indexPath.row]
        fundingProgram.isSelected = true
         fundingSummaryVC.fundingProgramSummary = fundingProgram
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
    
    
    
    //MARK : - Custom Search bar delegate
    func searchTextDidBegin(inSearchString:String)
    {
        print("searchTextDidBegin")
    }
    func searchTextWillChangeWithString(inSearchString:String)
    {
        filterListWithSearchString(searchString: inSearchString)
    }
    
    func searchTextCleared()
    {
        print("searchTextCleared")
        filterListWithSearchString(searchString: "")
        
    }
    func searchTextDidEndWithString(inSearchString:String)
    {
        print("searchTextDidEndWithString")
        filterListWithSearchString(searchString: inSearchString)
    }
    
    
    func filterListWithSearchString(searchString: String)
    {
        if searchString != ""
        {
            filteredFundingProgramList.removeAll()
            
            for savedApplicationObj : MCAFundingProgram in fundingProgramList {
                
                let stringToSearch = savedApplicationObj.fundingProgramName
                
                if stringToSearch == "" || ((stringToSearch?.localizedCaseInsensitiveContains(searchString)) == true) {
                    self.filteredFundingProgramList.append(savedApplicationObj)
                }
            }
            
            displayList = filteredFundingProgramList;
        }
        else {
            
            displayList = fundingProgramList;
        }
        
        tableView.reloadData();
    }
    
}
