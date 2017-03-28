//
//  MCASavedApplicationListVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASavedApplicationListVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [MCASavedApplicationList]()
    var savedApplicationList: MCASavedApplicationList!
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Saved Applications"
        
        for _ in 1...5
        {
            savedApplicationList = MCASavedApplicationList(data:nil)
            dataSource.append(savedApplicationList)
        }
        
        tableView.register(UINib(nibName: "MCASavedApplicationsListTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCASavedApplicationsListTVCell)
        tableView.tableFooterView = UIView()
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
        
        savedApplicationList = dataSource[indexPath.row]
        cell.setSavedApplicationList(savedApplicationData: savedApplicationList)

        cell.backgroundColor = ColorConstants.background
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "SavedApplication", bundle: Bundle.main)
        let applicationSummaryVC = storyBoard.instantiateViewController(withIdentifier: "MCAApplicationSummaryVC") as! MCAApplicationSummaryVC
        savedApplicationList = dataSource[indexPath.row]

        applicationSummaryVC.titleText = savedApplicationList.applicationName
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
