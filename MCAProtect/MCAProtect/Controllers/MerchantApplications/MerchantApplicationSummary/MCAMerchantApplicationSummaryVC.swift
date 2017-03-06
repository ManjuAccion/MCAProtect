//
//  MCAMerchantApplicationSummaryVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/3/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMerchantApplicationSummaryVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var matchFundingProgramButton : UIButton!
    @IBOutlet weak var copyApplicationButton : UIButton!
    
    
    var dataSourceKeys = ["Business Name","Contact Name","Loan Amount","Email","Telephone","Offered on"]
    var dataSourceValues = ["Miami Florists","Christian A","$75,000","chirstian.a@gmail.com","(123) 876 -876","2017-01-21"]
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Miami Florists"

        tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCAApplicationSummaryTVCell)
        tableView.tableFooterView = UIView()
        matchFundingProgramButton.titleEdgeInsets =  UIEdgeInsetsMake(0.0, 20.0, 0.0, 0.0);
        matchFundingProgramButton.imageEdgeInsets =   UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0);
        copyApplicationButton.titleEdgeInsets =  UIEdgeInsetsMake(0.0, 20.0, 0.0, 0.0);
        copyApplicationButton.imageEdgeInsets =   UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0);
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
        cell.backgroundColor = UIColor.clear

        cell.titleLabel.text = dataSourceKeys[indexPath.row]
        cell.dataTF.text = dataSourceValues[indexPath.row]
        
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
}
