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

    @IBOutlet weak var rangeSelectionLabel: UILabel!
    
    var rangePicker = UIPickerView()
    var blurView:UIVisualEffectView!
    
    var toolbar : UIToolbar?
    var doneButton : UIBarButtonItem?
    var pickerTitle : UIBarButtonItem?
    var rangeList = ["Custom","Current Week","Current Month","Previous Month","Current Quarter","Previous Quarter","Current Year"]

    
    
    weak var parentController: MCADashboardTabbarVC!

    //MARK: - View Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pipeLineTableView.register(UINib(nibName: "MCADealsPipelineTVCell", bundle: nil), forCellReuseIdentifier: CellIdentifiers.MCADealsPipelineTVCell)
        
        self.getDealsPipelineList()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource -
    
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
    
    func getDealsPipelineList() {
        
        self.showActivityIndicator()
        
        var endPoint = String()
        endPoint.append(MCAAPIEndPoints.BrokerDashBoardAPIEndpoint);
        endPoint.append("\(MCASessionManager.sharedSessionManager.mcapUser.brokerID!)");
        endPoint.append("?from_date=2017-01-01&to_date=2017-12-31")
        
        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:[:],
                                                                endPoint:endPoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()
                print("Success \(response)")
                
                if let items = response["data"].array
                {
                    let sortedResults = items.sorted { $0["application_state_id"].doubleValue < $1["application_state_id"].doubleValue }
                    print("Sorted Data \(sortedResults)")

                    for item in sortedResults {
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
    

    func blur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.isUserInteractionEnabled = false
        blurView.frame = self.view.bounds
        view.addSubview(blurView)
    }
    
    func unblur() {
        self.blurView.removeFromSuperview()
    }
    
    

    @IBAction func selectDateRange(_ sender: Any)
    {
        pickerTitle?.title = "Select Range"
        self.navigationController?.navigationBar.isHidden = true
        
        self.blur()
        self.view.addSubview(self.rangePicker)
        self.view.addSubview(self.toolbar!)
    }

    
    func initilazeToolBar() {
        toolbar = UIToolbar()
        toolbar?.barStyle = .blackTranslucent
        toolbar?.isTranslucent = true
        toolbar?.sizeToFit()
        toolbar?.backgroundColor = UIColor.red
        
        doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.inputToolbarDonePressed))
        doneButton?.tintColor = .white
        
        
        let fixed = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: self, action: nil)
        fixed.width = 10
        
        pickerTitle = UIBarButtonItem(title: "Select Range", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        pickerTitle?.setTitleTextAttributes([NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Medium", size: 18.0),
                                             NSForegroundColorAttributeName : UIColor.white], for: UIControlState.normal)
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar?.setItems([fixed,pickerTitle!,flexibleSpaceButton, doneButton!], animated: false)
        toolbar?.isUserInteractionEnabled = true
        
        
        toolbar?.frame = CGRect(x:0,
                                y:    self.rangePicker.frame.origin.y - 44, // right under the picker
            width:self.rangePicker.frame.width, // make them the same width
            height:44)
        
        
        
    }
    
    
    
    func inputToolbarDonePressed() {
        unblur()
        self.navigationController?.navigationBar.isHidden = false
        
        self.rangePicker.removeFromSuperview()
        self.toolbar?.removeFromSuperview()
        self.didItemSelected(rangeValue: "Current Year")
    }
    
    func didItemSelected(rangeValue : String)
    {
        let selectedString = rangeList[self.rangePicker.selectedRow(inComponent: 0)] as String
        rangeSelectionLabel.text = selectedString
    }
    
}
