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
    var endOfPage : Bool!
    

    //MARK: - View Life Cycle - 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Funding Programs", comment: "")
        pageCount = 0;
        getFundingProgramList()
        
        tableView.register(UINib(nibName: "MCAFPListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAFPListTableViewCell)
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
        paramDict["per_page"] = MCAAPIPageControls.pageSize
        
        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:paramDict,
                                                                endPoint:MCAAPIEndPoints.BrokerFunderProgramListEndpoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()
                self.pageCount = self.pageCount + 1
                
                let fundingProgramArray = response.arrayValue
                
                
                if fundingProgramArray.count == 0 {
                    self.endOfPage = true
                }
                else{
                    self.endOfPage = false
                }
                
            
                for item in fundingProgramArray {
                    self.fundingProgram = MCAFundingProgram(data:item)
                    self.fundingProgramList.append(self.fundingProgram)
                }
                
                self.filterListWithSearchString(searchString: self.seacrhBar.searchTextField.text!)
                
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAFPListTableViewCell", for: indexPath) as! MCAFPListTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        let fundingPgram = displayList[indexPath.row]
        
        cell.dataSource(data: fundingPgram)
        
    //    cell.delegate = self;
        
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
        return 90.0
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        if (tableView.indexPathsForVisibleRows?.last?.row)! + 1 == displayList.count{
            if endOfPage == false{
                getFundingProgramList()
            }
        }
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
