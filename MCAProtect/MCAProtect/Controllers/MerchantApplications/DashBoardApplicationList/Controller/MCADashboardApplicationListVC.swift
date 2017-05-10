//
//  MCAMerchantApplicationListVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/3/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCADashboardApplicationListVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,MCAApplicationTVCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var applicationState: Int!
    var titleText: String?

    var fromDateString : String!
    var toDateString : String!

    var merchantApplicationDetail : MCAMerchantApplicationDetail!
    var dataSource = [MCAMerchantApplicationDetail]()
    
    var selectedDealsPipeline : MCADealsPipeLine!

    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.selectedDealsPipeline.applicationStateName
        tableView.register(UINib(nibName: "MCAApplicationTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAApplicationListTVCell)
        tableView.tableFooterView = UIView()
        
        self.getApplicationList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleText = selectedDealsPipeline.applicationStateName
        applicationState = selectedDealsPipeline.applicationStateID
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getApplicationList() {
        
            if self.checkNetworkConnection() == false {
        return
    }
    
    self.showActivityIndicator()

        
        var endPoint = String()
        endPoint.append(MCAAPIEndPoints.BrokerApplicationSummaryAPIEndpoint);
        endPoint.append("\(MCASessionManager.sharedSessionManager.mcapUser.brokerID!)");
        endPoint.append("/\(selectedDealsPipeline.applicationStateID!)");
        
        endPoint.append("?from_date=\(fromDateString!)&to_date=\(toDateString!)")
        
        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:[:],
                                                                endPoint:endPoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()
                print("Success \(response)")
                
                if let items = response["data"].array
                {
                    for item in items {
                        self.merchantApplicationDetail = MCAMerchantApplicationDetail(merchantApplicationDetail:item)
                        self.dataSource.append(self.merchantApplicationDetail)
                    }
                    
                    self.tableView.reloadData()
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
    
    

    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationListTVCell, for: indexPath) as! MCAApplicationTVCell
        
        cell.delegate = self
        cell.applicationTVDelegate = self
        cell.selectionStyle = .none
        
        merchantApplicationDetail = dataSource[indexPath.row]
        cell.setMerchantApplicationList(merchantApplicationList: merchantApplicationDetail)
        
        cell.rightButton.isHidden = false
        cell.backgroundColor = UIColor.clear
        
        switch applicationState {
            case ApplicationState.New.rawValue:
                cell.rightButton.isHidden = true
            case ApplicationState.UnderWriting.rawValue:
                cell.rightButton.setImage(UIImage(named: "iconSubmit"), for: .normal)
            case ApplicationState.NeedMoreStips.rawValue :
                cell.rightButton.setImage(UIImage(named: "iconSubmit"), for: .normal)
            default:
                break
        }
        
        return cell
    }
    
    //MARK: - Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyBoard = UIStoryboard(name: StoryboardName.MCAMerchantApplication, bundle: Bundle.main)
        let applicationSummaryVC = storyBoard.instantiateViewController(withIdentifier: "MCADashBoardApplicationSummaryVC") as! MCADashBoardApplicationSummaryVC
        applicationSummaryVC.applicationState = applicationState
        
        merchantApplicationDetail = dataSource[indexPath.row]
        applicationSummaryVC.titleText = merchantApplicationDetail.businessName
        applicationSummaryVC.merchantApplicationDetail = merchantApplicationDetail;
        navigationController?.pushViewController(applicationSummaryVC, animated: true)
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCAApplicationTVCell
        selectedCell.selectedView.isHidden = false
        selectedCell.backgroundColor = ColorConstants.selectedBackground
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCAApplicationTVCell
        deselectedCell.selectedView.isHidden = true
        deselectedCell.backgroundColor = ColorConstants.background
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 96.0
    }
    
    func rightActionButtonTapped(_ sender: UIButton) {
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        merchantApplicationDetail = dataSource[(indexPath?.row)!]

        switch applicationState {
            case ApplicationState.UnderWriting.rawValue:
                let storyBoard = UIStoryboard(name: StoryboardName.MCAMerchantApplication, bundle: Bundle.main)
                let submitStipulationsVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAMASubmitStipulationsVC) as! MCAMASubmitStipulationsVC
                submitStipulationsVC.merchantApplicationDetail = merchantApplicationDetail
                submitStipulationsVC.applicationState = ApplicationState.UnderWriting.rawValue
                navigationController?.pushViewController(submitStipulationsVC, animated: true)

            case ApplicationState.NeedMoreStips.rawValue:
                let storyBoard = UIStoryboard(name: StoryboardName.MCAMerchantApplication, bundle: Bundle.main)
                let submitStipulationsVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAMASubmitStipulationsVC) as! MCAMASubmitStipulationsVC
                submitStipulationsVC.merchantApplicationDetail = merchantApplicationDetail
                navigationController?.pushViewController(submitStipulationsVC, animated: true)
            default:
                break
        }
    }

    
        
}


