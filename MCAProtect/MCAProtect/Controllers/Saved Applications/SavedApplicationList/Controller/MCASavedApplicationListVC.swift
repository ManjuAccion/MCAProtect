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
    
    var dataDataSource = ["The Jewellery Shop", "Stacy's Boutique", "Miami Florists", "Food Truck", "Sport's World"]
    var amountDataSource = ["$2000","$3000","$4000","$5000","$6000"]

    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadUI() {
        
        self.navigationItem.title = "Saved Applications"
        tableView.register(UINib(nibName: "MCASavedApplicationsListTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCASavedApplicationsListTVCell)
        tableView.tableFooterView = UIView()
    }
    
    //MARK: - Table View Datasource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCASavedApplicationsListTVCell, for: indexPath) as! MCASavedApplicationsListTVCell
        cell.delegate = self
        cell.selectionStyle = .none
        cell.nameLabel.text = dataDataSource[indexPath.row]
        cell.amountLabel.text = amountDataSource[indexPath.row]
        cell.backgroundColor = ColorConstants.background
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "SavedApplication", bundle: Bundle.main)
        let applicationSummaryVC = storyBoard.instantiateViewController(withIdentifier: "MCAApplicationSummaryVC") as! MCAApplicationSummaryVC
        applicationSummaryVC.titleText = dataDataSource[indexPath.row]
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
        return 113.0
    }
}
