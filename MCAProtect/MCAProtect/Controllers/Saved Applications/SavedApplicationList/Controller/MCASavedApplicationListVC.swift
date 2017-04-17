//
//  MCASavedApplicationListVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCASavedApplicationListVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,MCARefreshDelegate,MCACustomSearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: MCACustomSearchBar!
    
    var dataSource = [MCASavedApplication]()
    var displayList = [MCASavedApplication]()
    var filteredDisplayList = [MCASavedApplication]()
    var selectedSavedApplication: MCASavedApplication!
    
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Saved Applications"
        
        
        tableView.contentInset = .zero
        tableView.register(UINib(nibName: "MCASavedApplicationsListTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCASavedApplicationsListTVCell)
        tableView.tableFooterView = UIView()
        
        getSavedApplicationList()
//        tableView.addRefreshController()
//        tableView.refreshDelegate = self
        searchBar.delegate = self;
        
    }
    
    func refreshContents()
    {
        getSavedApplicationList()
    }

    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.configureUI()
        tableView.reloadData()
    }
    
    func getSavedApplicationList()
    {
        
        self.showActivityIndicator()
        
        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:[:],
                                                                endPoint:MCAAPIEndPoints.BrokerSavedApplicationListEndpoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()
                self.dataSource.removeAll()
                
                let savedApplicationDict = response.dictionaryValue
                let list = savedApplicationDict["data"]
                let savedAppList = list?.arrayValue
                
                for item in savedAppList! {
                    let savedApp = MCASavedApplication(savedApplcation:item)
                    self.dataSource.append(savedApp)
                }
                self.displayList = self.dataSource
                self.tableView.reloadData()
        },
              failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Unable to fetch Saved Applications", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Table View Datasource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCASavedApplicationsListTVCell, for: indexPath) as! MCASavedApplicationsListTVCell
        cell.delegate = self
        cell.selectionStyle = .none
        
        let savedApp = displayList[indexPath.row]
        cell.setSavedApplicationList(savedApplicationData: savedApp)
        cell.backgroundColor = ColorConstants.background
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if nil != selectedSavedApplication {
            selectedSavedApplication.isSelected = false
        }
    
        let storyBoard = UIStoryboard(name: "SavedApplication", bundle: Bundle.main)
        let applicationSummaryVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAApplicationSummaryVC) as! MCAApplicationSummaryVC
        selectedSavedApplication = displayList[indexPath.row]
        selectedSavedApplication.isSelected = true
        applicationSummaryVC.appSummary = selectedSavedApplication
        tableView.reloadData()
        navigationController?.pushViewController(applicationSummaryVC, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 96.0
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
            filteredDisplayList.removeAll()
            
            for savedApplicationObj : MCASavedApplication in dataSource {
                
                let stringToSearch = savedApplicationObj.applicationName
                
                if stringToSearch == "" || ((stringToSearch?.localizedCaseInsensitiveContains(searchString)) == true) {
                    self.filteredDisplayList.append(savedApplicationObj)
                }
            }
            
            self.displayList = filteredDisplayList;
        }
        else {
            
            self.displayList = self.dataSource;
        }
        
        tableView.reloadData();
    }

}
