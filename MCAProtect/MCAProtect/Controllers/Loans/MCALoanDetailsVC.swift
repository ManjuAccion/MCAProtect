//
//  MCALoanDetailsVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/15/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCALoanDetailsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = ["Business Name":"Stacy's Botique", "Credit Score":"442", "Loan Amount":"$75000", "Loan Term":"6 Months", "Need it by":"5 Days"]
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
        
        self.title = "Loan Details"
        tableView.register(UINib(nibName: "MCADataDetailsTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCADataDetailsTVCell")
        tableView.tableFooterView = UIView()
        
        dataSourceArray = Array(dataSource.keys)
        
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCADataDetailsTVCell", for: indexPath) as! MCADataDetailsTVCell
        
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
