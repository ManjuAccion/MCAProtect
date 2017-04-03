//
//  MCADealsPipelineVC.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON
class MCADealsPipelineVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var pipeLineTableView: UITableView!
    
    var dealsPipeline : MCADealsPipeLine!
    var dataSourceArray = [MCADealsPipeLine]()

    weak var parentController: MCADashboardTabbarVC!

    
    func getDealsPipelineList() {
        
        
        self.showActivityIndicator()
        var paramDict  = Dictionary<String, String>()

        var endPoint = String()
        endPoint.append(MCAAPIEndPoints.BrokerDashBoardAPIEndpoint);
        endPoint.append("\(MCASessionManager.sharedSessionManager.mcapUser.brokerID!)");
        endPoint.append("?from_date=2017-01-01&to_date=2017-12-31")

        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:paramDict,
                                                                endPoint:endPoint
            , successCallBack:{ (response : Dictionary<String, AnyObject>!) in
                
                self.stopActivityIndicator()
                print("Success \(response)")
                
                if let items = response["data"] as? [[String:AnyObject]]
                {
                    for item in items {
                        self.dealsPipeline = MCADealsPipeLine(dealsPipeLine:item)
                        self.dataSourceArray.append(self.dealsPipeline)
                    }
                    
                    self.pipeLineTableView.reloadData()
                }
                
        },
              failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Dashboard update Failed", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
    
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        pipeLineTableView.register(UINib(nibName: "MCADealsPipelineTVCell", bundle: nil), forCellReuseIdentifier: CellIdentifiers.MCADealsPipelineTVCell)
        
        
        self.getDealsPipelineList()

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
        applicationVC.selectedDealsPipeline = dealsPipeline;
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

    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
}
