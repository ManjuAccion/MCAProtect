//
//  MCADealsPipelineVC.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON
class MCADealsPipelineVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate {

    @IBOutlet weak var pipeLineTableView: UITableView!
    
    var dealsPipeline : MCADealsPipeLine!
    var dataSourceArray = [MCADealsPipeLine]()
    var pickerViewPopup : UIActionSheet!
    @IBOutlet weak var rangeSelectionLabel: UILabel!
    
    var rangePicker = UIPickerView()
    var blurView:UIVisualEffectView!
    
    var toolbar : UIToolbar?
    var doneButton : UIBarButtonItem?
    var pickerTitle : UIBarButtonItem?
    var rangeList = Array<String>()
    

    var customDatePicker : MCACustomDatePickerView!
    var customPicker : MCACustomPickerView!
    weak var parentController: MCADashboardTabbarVC!

    //MARK: - View Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pipeLineTableView.register(UINib(nibName: "MCADealsPipelineTVCell", bundle: nil), forCellReuseIdentifier: CellIdentifiers.MCADealsPipelineTVCell)
        
        
        rangeList.append("Custom")
        rangeList.append("Current Week")
        rangeList.append("Current Month")
        rangeList.append("Previous Month")
        rangeList.append("Current Quarter")
        rangeList.append("Previous Quarter")
        rangeList.append("Current Year")
        

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
    

    
    //MARK: - PickerView Datasource and Delegates
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return rangeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rangeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let strTitle = rangeList[row]
        let attString = NSAttributedString(string: strTitle, attributes: [NSForegroundColorAttributeName : ColorConstants.red])
        return attString
    }
    
    
    

    @IBAction func selectDateRange(_ sender: Any)
    {
        
        customDatePicker =  Bundle.main.loadNibNamed("MCACustomDatePickerView", owner: self, options: nil)?[0] as! MCACustomDatePickerView
        

        customDatePicker.frame = self.parentController.view.bounds
        customDatePicker.layoutIfNeeded()
        self.parentController.view.addSubview(customDatePicker)

        
//            customPicker =  Bundle.main.loadNibNamed("MCACustomPickerView", owner: self, options: nil)?[0] as! MCACustomPickerView
//        customPicker.setDatasource(dataSource: rangeList)
        
//        customPicker.frame = self.parentController.view.bounds
//        customPicker.layoutIfNeeded()
//        self.parentController.view.addSubview(customPicker)
    }
    
    func test()
    {
        
        pickerViewPopup = UIActionSheet(title: "Select Range", delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "")
        
        
        rangePicker = UIPickerView(frame: CGRect(x: 0, y: 44, width: 320, height: 200))
        
        rangePicker.delegate = self
        rangePicker.dataSource = self
        rangePicker.showsSelectionIndicator = true

        
        
        toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        toolbar?.barStyle = .blackOpaque
        toolbar?.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem:.flexibleSpace , target: self, action: nil)
        let doneBtn = UIBarButtonItem(barButtonSystemItem:.done , target: self, action: nil)
        
        
        toolbar?.setItems([flexSpace, doneBtn], animated: true)
        
        pickerViewPopup.addSubview(toolbar!);
        pickerViewPopup.addSubview(rangePicker)
        pickerViewPopup.show(in: self.view)
        pickerViewPopup.bounds = CGRect(x: 0, y: 0, width: 320, height: 300)
    }

    
    
    func didItemSelected(rangeValue : String)
    {
        let selectedString = rangeList[self.rangePicker.selectedRow(inComponent: 0)] as String
        rangeSelectionLabel.text = selectedString
    }
    
}
