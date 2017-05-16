//
//  MCABrokersListVC.swift
//  MCAProtect
//
//  Created by Sarath Neeravallil on 10/05/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCABrokersListVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,MCACustomSearchBarDelegate {

    
    @IBOutlet weak var searchBar: MCACustomSearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var brokerList : MCABrokerList!
    
    var dataSource = [MCABrokerList]()
    var displayList = [MCABrokerList]()
    var filteredDisplayList = [MCABrokerList]()
    
    //MARK: - View Life Cycle -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Brokers"
        tableView.register(UINib(nibName: "MCABrokersListTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCABrokersListTVCell)
        tableView.tableFooterView = UIView()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"iconPlus"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(addBroker))
        searchBar.delegate = self
        
        getBrokerList()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.configureUI()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addBroker() {
        
        let storyBoard = UIStoryboard(name: StoryboardName.MCABroker, bundle: Bundle.main)
        let createBrokerVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCACreateBrokerVC) as! MCACreateBrokerVC
        navigationController?.pushViewController(createBrokerVC, animated:true)
    }
    
    func getBrokerList() {
        
        if self.checkNetworkConnection() == false {
            return
        }
        
        self.showActivityIndicator()
        
        var endPoint = String()
        endPoint.append(MCAAPIEndPoints.BrokerageFirmBrokersAPIEndpoint)
        endPoint.append("\(MCASessionManager.sharedSessionManager.mcapUser.brokerID!)")
        
        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:[:],
                                                                endPoint:endPoint
            , successCallBack:{ (response : JSON) in
                self.stopActivityIndicator()
                print("Success \(response)")
                self.dataSource.removeAll()

                if let items = response.array
                {
                    for item in items {
                        self.brokerList = MCABrokerList(broker:item)
                        self.dataSource.append(self.brokerList)
                    }
                    self.displayList = self.dataSource
                    self.tableView.reloadData()
                }
        },
              failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Unable to fetch broker details", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
        })
        
    }

    //MARK: - Table View DataSource Methods -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCABrokersListTVCell, for: indexPath) as! MCABrokersListTVCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = ColorConstants.background
        
        brokerList = displayList[indexPath.row]
        cell.setBrokerList(brokerList: brokerList)
        
        return cell

    }
    
    //MARK: - Table View Delegate Methods-

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //MARK : - Custom Search bar delegate
    
    func searchTextDidBegin(inSearchString:String) {
        print("searchTextDidBegin")
    }
    
    func searchTextWillChangeWithString(inSearchString:String) {
        filterListWithSearchString(searchString: inSearchString)
    }
    
    func searchTextCleared() {
        filterListWithSearchString(searchString: "")
    }
    
    func searchTextDidEndWithString(inSearchString:String) {
        filterListWithSearchString(searchString: inSearchString)
    }
    
    func filterListWithSearchString(searchString: String) {
        
        if searchString != "" {
            
            filteredDisplayList.removeAll()
            
            for brokerListObj : MCABrokerList in dataSource {
                
                let stringToSearch = brokerListObj.contactName
                
                if stringToSearch == "" || ((stringToSearch?.localizedCaseInsensitiveContains(searchString)) == true) {
                    self.filteredDisplayList.append(brokerListObj)
                }
            }
            
            displayList = filteredDisplayList
        }
        else {
            
            displayList = self.dataSource
        }
        
        tableView.reloadData()
    }
    
}
