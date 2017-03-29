//
//  MCADealsPipelineVC.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCADealsPipelineVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var pipeLineTableView: UITableView!
    
    var dealsPipeline : MCADealsPipeLine!
    var dataSourceArray = [MCADealsPipeLine]()

    weak var parentController: MCADashboardTabbarVC!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...7 {
            
            dealsPipeline = MCADealsPipeLine(data:nil)
            dataSourceArray.append(dealsPipeline)
        }

        pipeLineTableView.register(UINib(nibName: "MCADealsPipelineTVCell", bundle: nil), forCellReuseIdentifier: CellIdentifiers.MCADealsPipelineTVCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCADealsPipelineTVCell) as! MCADealsPipelineTVCell!
        cell?.selectionStyle = .none
        
        dealsPipeline = dataSourceArray[indexPath.row]
        cell?.setDealsPipeline(dealsPipeline: dealsPipeline)
        
        return cell!
    }
    
    //MARK: - Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let applicationVC  = UIStoryboard(name: StoryboardName.MCAMerchantApplication, bundle: nil).instantiateViewController(withIdentifier:VCIdentifiers.MCAMerchantApplicationListVC) as! MCAMerchantApplicationListVC
        
        dealsPipeline = dataSourceArray[indexPath.row]
        applicationVC.titleText = dealsPipeline.applicationStateName
        applicationVC.applicationState = dealsPipeline.applicationStateID
        parentController.navigationController?.pushViewController(applicationVC, animated: true);
    }


}
