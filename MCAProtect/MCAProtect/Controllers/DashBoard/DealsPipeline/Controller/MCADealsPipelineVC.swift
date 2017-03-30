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
            
            dealsPipeline = MCADealsPipeLine(dealsPipeLine:"")
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
    
//    func loadDealsPipeline() {
//        
//        self.showActivityIndicator()
//        
//        var paramDict = Dictionary<String, String>()
//        paramDict["email"] = emailIDTextField.text
//        paramDict["password"] = passwordTextField.text
//        
//        
//        MCAWebServiceManager.sharedWebServiceManager.postRequest(requestParam:paramDict,
//                                                                 endPoint:"/broker/sign_in.json"
//            , successCallBack:{ (response : Any) in
//                self.stopActivityIndicator()
//                print("Success \(response)")
//        }, failureCallBack: { (response : Any, error : Error) in
//            self.stopActivityIndicator()
//            print("Failure \(error)")
//            let alertViewController = UIAlertController(title : "MCAP", message : "Login Failed", preferredStyle : .alert)
//            alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
//            self.present(alertViewController, animated: true , completion: nil)
//            
//        })
//
//    }

}
