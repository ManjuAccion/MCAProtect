//
//  MCAMASubmitStipulationsVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/9/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAMASubmitStipulationsVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,MCASubmitStipulationsCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popUpView : UIView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var transparentImageView : UIImageView!

    
    var merchantApplicationDetail : MCAMerchantApplicationDetail!

    
    var dataSource : [JSON] = []
    
    var doctUrl : URL!

    //MARK: -View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MCASubmitStipulationsCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCASubmitStipulationsCell)
        self.title = merchantApplicationDetail.businessName
        popUpView.alpha = 0.0
        transparentImageView.alpha = 0.0
        getDocumentsList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDocumentsList()
    {
        if self.checkNetworkConnection() == false {
            return
        }
        
        self.showActivityIndicator()
        
        var endPoint = String()
        endPoint.append(MCAAPIEndPoints.BrokerNeedMoreStipDocEndpoint);
        endPoint.append("/\(merchantApplicationDetail.applicationID!)");
        endPoint.append("/\(merchantApplicationDetail.acceptedFundingProgramID!)");
        
        
        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:[:],
                                                                endPoint:endPoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()
                print("Success \(response)")
                let responseDcit = response.dictionaryValue;
                self.dataSource = (responseDcit["stipulations"]?.array)!
                
                self.tableView.reloadData()
        },
              failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Dashboard update Failed", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
    }
    
    //MARK: - Table View DataSource functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCASubmitStipulationsCell) as! MCASubmitStipulationsCell
        cell.delegate = self
        cell.setSubmitStipulationsCell(documentDetail: dataSource[indexPath.row])
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    //MARK: - Table View Delegate functions
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = Bundle.main.loadNibNamed("MCASubmitStipulationsView", owner: self, options: nil)?[0] as! MCASubmitStipulationsView
        footerView.addMoreDocumentsButton.layer.cornerRadius = 3.0
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func viewApplication(docUrl : URL)
    {
       doctUrl = docUrl
        
        showAnimate(docUrl: doctUrl)
    }
    
    func showAnimate(docUrl : URL!)
    {
        let requestObj = URLRequest(url: docUrl)
        webView.loadRequest(requestObj)
        
        self.popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.popUpView.alpha = 0.0
        self.transparentImageView.alpha = 1.0
        UIView.animate(withDuration: 0.25, animations: {
            self.popUpView.alpha = 1.0
            self.popUpView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate()
    {
        self.transparentImageView.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.popUpView.alpha = 0.0
        })
    }
    
    @IBAction func closePopUpView()
    {
    removeAnimate()
    
    }
    
  }
