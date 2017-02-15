//
//  MCAMerchantDetailsVC
//  MCAProtect
//
//  Created by Sarath NS on 2/15/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMerchantDetailsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataDataSource = ["Business Information", "Business Address", "Liens/Payments/Bankruptcy", "Merchant Documentation", "Bank Records","MCA Loans","Owner/Officer Information","Business Location"]
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadUI() {
        
        self.title = "Stacty's Boutique Details"
        tableView.register(UINib(nibName: "MCAStatusTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAStatusTVCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        self.automaticallyAdjustsScrollViewInsets = false
        tableView.tableFooterView = UIView()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell :UITableViewCell!
        
        if indexPath.row == 0 {
            let statusTVCell = tableView.dequeueReusableCell(withIdentifier: "MCAStatusTVCell", for: indexPath) as! MCAStatusTVCell
            statusTVCell.statusLabel.text = "Progress"
            cell = statusTVCell
        }
        else {
            let defaultCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
            defaultCell.textLabel?.text = dataDataSource[indexPath.row]
            cell = defaultCell
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 46.0
    }

    
    
}
