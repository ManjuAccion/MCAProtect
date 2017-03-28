//
//  MCASALiensPaymentsVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 01/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASALiensPaymentsVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Liens/Payments"
        
        tableView.register(UINib(nibName: "MCALiensPaymentsTVCell", bundle: Bundle.main), forCellReuseIdentifier:"MCALiensPaymentsTVCell")
        tableView.register(UINib(nibName: "MCABankruptcyTVCell", bundle: Bundle.main), forCellReuseIdentifier:"MCABankruptcyTVCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table view DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell!
        
        if indexPath.row == 0 {
            
        
       let  lienspaymentsCell = tableView.dequeueReusableCell(withIdentifier: "MCALiensPaymentsTVCell", for: indexPath) as! MCALiensPaymentsTVCell
             lienspaymentsCell.cellDatasource()
            cell = lienspaymentsCell
            
        }
        else{
            
            let  bankruptcyCell = tableView.dequeueReusableCell(withIdentifier: "MCABankruptcyTVCell", for: indexPath) as! MCABankruptcyTVCell
            cell = bankruptcyCell
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear

        
        return cell
    }
    
    //MARK: - Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (indexPath.row == 0) {
        return 250.0
        }
        else{
            return 215.0
        }
    }


}
