//
//  MCASavedApplicationListVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCASavedApplicationListVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: MCACustomSearchBar!
    
    var dataSource = [MCASavedApplication]()
    var selectedSavedApplication: MCASavedApplication!
    
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Saved Applications"
        
        
        tableView.contentInset = .zero
        tableView.register(UINib(nibName: "MCASavedApplicationsListTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCASavedApplicationsListTVCell)
        tableView.tableFooterView = UIView()
        
        self.getSavedApplicationList()
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
                
                let savedApplicationDict = response.dictionaryValue
                
                let list = savedApplicationDict["data"]
                
                let savedAppList = list?.arrayValue
                
                for item in savedAppList! {
                    let savedApp = MCASavedApplication(savedApplcation:item)
                    self.dataSource.append(savedApp)
                }
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
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCASavedApplicationsListTVCell, for: indexPath) as! MCASavedApplicationsListTVCell
        cell.delegate = self
        cell.selectionStyle = .none
        
        let savedApp = dataSource[indexPath.row]
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
        selectedSavedApplication = dataSource[indexPath.row]
        selectedSavedApplication.isSelected = true
        applicationSummaryVC.appSummary = selectedSavedApplication
        tableView.reloadData()
        navigationController?.pushViewController(applicationSummaryVC, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 96.0
    }
}
