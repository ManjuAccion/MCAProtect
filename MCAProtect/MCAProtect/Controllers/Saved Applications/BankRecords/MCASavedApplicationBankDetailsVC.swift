//
//  MCASavedApplicationBankDetailsVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/1/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASavedApplicationBankDetailsVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var bankName: String?
    
    let bankDetailsArray = ["Account Number","Range","Statement Period","Number of Deposits","Deposit Amount","Days with Negative Balance","Average Daily Balance"]
    let bankDetailsValueArray  = ["BOA546897236","1st Nov 2016 31st Dec 2016","1st-Nov-2016_31st-Dec-2016.pdf","20","$75,000","0","$3,300"]
    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MCASavedApplicationsBankDetailsTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCASavedApplicationsBankDetailsTVCell)
        tableView.tableFooterView = UIView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"iconEdit"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(editButtonTapped))
        self.title = bankName

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCASavedApplicationsBankDetailsTVCell, for: indexPath) as! MCASavedApplicationsBankDetailsTVCell
        cell.selectionStyle = .none
        
        cell.headingLabel.text = bankDetailsArray[indexPath.row]
        cell.dataTF.text = bankDetailsValueArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    func editButtonTapped() {
        
    }
    
    
    
   
}
