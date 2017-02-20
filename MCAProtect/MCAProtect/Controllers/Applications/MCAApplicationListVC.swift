//
//  MCAApplicationListVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAApplicationListVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
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
        
        self.title = "Underwriting"
        tableView.register(UINib(nibName: "MCAApplicationTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationTVCell")
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.tableFooterView = UIView()
    }
    
    //MARK: - Table View Datasource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationTVCell", for: indexPath) as! MCAApplicationTVCell
        
        cell.selectionStyle = .none
        
        cell.merchantName.text = dataDataSource[indexPath.row]
        cell.amountLabel.text = amountDataSource[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Application", bundle: Bundle.main)
        let underwritingMerchantVC = storyBoard.instantiateViewController(withIdentifier: "MCAApplicationSummaryVC") as! MCAApplicationSummaryVC
        navigationController?.pushViewController(underwritingMerchantVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 68.0
    }


}
