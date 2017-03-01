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
        
        tableView.register(UINib(nibName: "MCALiensPaymentsTVCell", bundle: Bundle.main), forCellReuseIdentifier:"MCALiensPaymentsTVCell")
        tableView.register(UINib(nibName: "MCABankruptcyTVCell", bundle: Bundle.main), forCellReuseIdentifier:"MCABankruptcyTVCell")


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (indexPath.row == 0) {
            let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCALiensPaymentsTVCell

            selected.liensViewBottomConstraints.constant = 175.0

        return 60.0
        }
        else{
            
            return 60.0

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
