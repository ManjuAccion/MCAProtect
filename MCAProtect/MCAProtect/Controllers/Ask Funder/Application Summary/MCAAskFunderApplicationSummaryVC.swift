//
//  MCAAskFunderApplicationSummaryVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAAskFunderApplicationSummaryVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,MCAApplicationSummaryTVCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSourceKeys = ["Merchant","Loan Value","Term","Referred to","Referred on","Status"]
    var dataSourceValues = ["OySprays","$60,000.00","1 Month","Snap Advices","7 Days ago","Accepted"]
    var titleText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = titleText
        tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCAApplicationSummaryTVCell)
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
        
        cell.selectionStyle = .none
        cell.titleLabel.text = dataSourceKeys[indexPath.row]
        cell.dataTF.text = dataSourceValues[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.delegate = self
        
        if indexPath.row == 0 {
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.viewDetailsButton.isHidden = false
            cell.viewDetailsButton.setImage(UIImage(named:"iconChat"), for: UIControlState.normal)
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let applicationFormVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAApplicationFormVC) as! MCAApplicationFormVC
            navigationController?.pushViewController(applicationFormVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }

    
    func rightActionButtonTapped() {
        let storyBoard = UIStoryboard(name: StoryboardName.MCAAskFunder, bundle: Bundle.main)
        let askFunderChatDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAAskFunderChatDetailVC) as! MCAAskFunderChatDetailVC
        navigationController?.pushViewController(askFunderChatDetailVC, animated: true)
    }

    
 
}
