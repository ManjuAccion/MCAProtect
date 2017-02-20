//
//  MCAApplicationSummaryVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAApplicationSummaryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = ["Business Name":"Stacy's Botique", "Contact Name":"Helen", "Loan Amount":"$75000", "Email":"helen.parker@gmail.com", "Telephone":"(123) 123-1239","Offered on":"2017-01-12"]
    
    var dataSourceArray : [String] = []
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem(title: "",
                                         style: UIBarButtonItemStyle.plain,
                                         target: navigationController,
                                         action: nil)
        navigationItem.leftBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadUI() {
        
        self.title = "Stacy's Boutique"
        tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationSummaryTVCell")
//        self.automaticallyAdjustsScrollViewInsets = false
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
