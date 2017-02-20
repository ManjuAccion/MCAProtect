//
//  MCABusinessInformationVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/15/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABusinessInformationVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = ["Legal Business Name":"Stacy's Botique", "Contact Name":"Helen", "Loan Amount":"$75000", "Email":"helen.parker@gmail.com", "Telephone":"(123) 123-1239","Federal Tax ID":"2017896","Gross Annual Sales":"$3,00,000","Business Entity Type":"Partnership"]
    
    var dataSourceArray : [String] = []
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadUI() {
        
        self.title = "Business Information"
        tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationSummaryTVCell")
        tableView.tableFooterView = UIView()
        
        dataSourceArray = Array(dataSource.keys)
        
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationSummaryTVCell", for: indexPath) as! MCAApplicationSummaryTVCell
        
        cell.selectionStyle = .none
        let title = dataSourceArray[indexPath.row]
        cell.dataTF.placeholder = title
        cell.dataTF.text = dataSource[title]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    

}
