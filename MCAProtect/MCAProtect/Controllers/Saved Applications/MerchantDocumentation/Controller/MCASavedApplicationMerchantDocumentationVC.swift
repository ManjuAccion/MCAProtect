//
//  MCASavedApplicationMerchantDocumentationVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/1/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASavedApplicationMerchantDocumentationVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var merchantDocumentation : MCAMerchantDocumentation!

    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        merchantDocumentation = MCAMerchantDocumentation(merchantDocumentation:"")
        self.title = "Merchant Documentation"
        tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell)
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return merchantDocumentation.fieldCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        switch indexPath.row
        {
            case MerchantDocumentationKeys.proofOfIdentity.hashValue:
                cell.setMerchantDocumentation(merchantDocumentation: merchantDocumentation, merchantDocumentationKey: MerchantDocumentationKeys.proofOfIdentity)
                
            case MerchantDocumentationKeys.proofOfResidence .hashValue:
                cell.setMerchantDocumentation(merchantDocumentation: merchantDocumentation, merchantDocumentationKey: MerchantDocumentationKeys.proofOfResidence)
            
            default: break;
        }
        
        cell.viewDetailsButton.setImage(UIImage(named: "iconDownload"), for: UIControlState.normal)
        cell.viewDetailsButton.isHidden = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }

}
