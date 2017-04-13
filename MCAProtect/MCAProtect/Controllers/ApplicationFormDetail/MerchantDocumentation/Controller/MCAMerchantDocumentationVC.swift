//
//  MCAMerchantDocumentationVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/1/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMerchantDocumentationVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var merchantDocumentation : MCAMerchantDocumentation!
    var loanApplication : MCALoanApplication!
    var merchantDocumentationArray : [MCAMerchantDocumentation]!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        merchantDocumentationArray = loanApplication.merchantDocumentation
        self.title = "Merchant Documentation"
        tableView.register(UINib(nibName: "MCAMerchantDocumentationTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAMerchantDocumentationTVCell)
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return merchantDocumentationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAMerchantDocumentationTVCell, for: indexPath) as! MCAMerchantDocumentationTVCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        merchantDocumentation = merchantDocumentationArray[indexPath.row]
        cell.setMerchantDocumentation(merchantDocumentation: merchantDocumentation)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 96.0
    }

}
