//
//  MCAMerchantApplicationListVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/3/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMerchantApplicationListVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var applicationState: Int!
    var titleText: String?
    
    var dataDataSource = ["The Jewellery Shop", "Stacy's Boutique", "Miami Florists", "Food Truck", "Sport's World"]
    var amountDataSource = ["$2000","$3000","$4000","$5000","$6000"]
    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = titleText

        tableView.register(UINib(nibName: "MCAApplicationTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAApplicationListTVCell)
        tableView.tableFooterView = UIView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationListTVCell, for: indexPath) as! MCAApplicationTVCell
        
        cell.selectionStyle = .none
        cell.headingLabel.text = dataDataSource[indexPath.row]
        cell.detailLabel.text = amountDataSource[indexPath.row]
        cell.rightButton.isHidden = false
        cell.backgroundColor = UIColor.clear
        
        switch applicationState {
        case ApplicationState.New.rawValue:
            cell.rightButton.isHidden = true

        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyBoard = UIStoryboard(name: StoryboardName.MCAMerchantApplication, bundle: Bundle.main)
        let applicationSummaryVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAMerchantApplicationSummaryVC) as! MCAMerchantApplicationSummaryVC
        navigationController?.pushViewController(applicationSummaryVC, animated: true)
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCAApplicationTVCell
        selectedCell.selectedView.isHidden = false
        selectedCell.backgroundColor = ColorConstants.selectedBackground
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCAApplicationTVCell
        deselectedCell.selectedView.isHidden = true
        deselectedCell.backgroundColor = ColorConstants.background
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
}
