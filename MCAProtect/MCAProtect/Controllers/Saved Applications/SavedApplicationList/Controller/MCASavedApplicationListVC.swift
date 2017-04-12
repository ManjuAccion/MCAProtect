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
    
    var dataSource = [MCASavedApplication]()
    var savedApplication: MCASavedApplication!
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Saved Applications"
        
        
        tableView.register(UINib(nibName: "MCASavedApplicationsListTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCASavedApplicationsListTVCell)
        tableView.tableFooterView = UIView()
        
        self.getSavedApplicationList()
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
                    let savedApplication = MCASavedApplication(savedApplcation:item)
                    self.dataSource.append(savedApplication)
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
        
        savedApplication = dataSource[indexPath.row]
        cell.setSavedApplicationList(savedApplicationData: savedApplication)

        cell.backgroundColor = ColorConstants.background
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "SavedApplication", bundle: Bundle.main)
        let applicationSummaryVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAApplicationSummaryVC) as! MCAApplicationSummaryVC
        savedApplication = dataSource[indexPath.row]
        applicationSummaryVC.appSummary = savedApplication
        applicationSummaryVC.titleText = savedApplication.applicationName
        navigationController?.pushViewController(applicationSummaryVC, animated: true)
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCASavedApplicationsListTVCell
        selectedCell.selectedView.isHidden = false
        selectedCell.backgroundColor = ColorConstants.selectedBackground
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCASavedApplicationsListTVCell
        deselectedCell.selectedView.isHidden = true
        deselectedCell.backgroundColor = ColorConstants.background
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 96.0
    }
}
