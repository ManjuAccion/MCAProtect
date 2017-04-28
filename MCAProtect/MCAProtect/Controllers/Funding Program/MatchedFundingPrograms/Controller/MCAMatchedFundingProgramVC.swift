//
//  MCAMatchedFundingProgramVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 08/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAMatchedFundingProgramVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource,MatchedFundingProgramCellDelegate,MatchedFundingProgramDetailCellDelegate,MCAPickerViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedCountLabel : UILabel!
    
    var blurView:UIVisualEffectView!
    
    var headerView : MCAFundingProgramDetailCell!
    var toolbar : UIToolbar?
    var doneButton : UIBarButtonItem?
    var pickerTitle : UIBarButtonItem?
    
    var customPicker : MCACustomPickerView!

    
    
    var indexPath: NSIndexPath!
    
    var applicationState: Int!
    var pickerState: Int!
    var applicationId       : Int!
    
    
    
    var rates = [String]()
    
    var matchedFPList : NSMutableArray!
    
    var matchedFundingProgram : MCAMatchedFundingProgram!
    var merchantApplicationDetails :   MCAMerchantApplicationDetail!
    var fundingProgram : MCAFundingProgram!
    var matchedFundingProgramList = [MCAFundingProgram]()
    var selectedFundingPrograms = [[String:String]]()
    var selectedItemsCount = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Matched funding Program title", comment: "")

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"iconInfo"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.rightBarButtonclicked))
        tableView.register(UINib(nibName: "MCAMatchedFPListTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAMatchedFPListTVCell")
        tableView.register(UINib(nibName: "MCAFundingProgramDetailCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAFundingProgramDetailCell")
        tableView.tableFooterView = UIView()

        getMatchedFundingProgramList()

        
    }
    
    func rightBarButtonclicked()
    {
        let TitleString = NSAttributedString(string: NSLocalizedString("Matched Funding Program with Merchant Application", comment: ""), attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Regular", size: 18.0), NSForegroundColorAttributeName : UIColor.black])
        let MessageString = NSAttributedString(string: NSLocalizedString("Matched Funding Program Info", comment: ""), attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Light", size: 12.0), NSForegroundColorAttributeName : UIColor.gray])
        
        let alertViewController = UIAlertController(title : "", message : "", preferredStyle : .alert)
        alertViewController.setValue(TitleString, forKey: "attributedTitle")
        alertViewController.setValue(MessageString, forKey: "attributedMessage")
        alertViewController.view.tintColor = ColorConstants.red
        
        
        
        alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
        present(alertViewController, animated: true , completion: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        
        self.calculateFundingProgramSelectionCount()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    func getMatchedFundingProgramList()
    {
        if self.checkNetworkConnection() == false {
            return
        }
        
        self.showActivityIndicator()
        
        
        var paramDict = Dictionary<String , Any>()
        
        paramDict["data"] = ["application_id" : applicationId.description]
        
        //  paramDict["application_id"] = applicationId.description
        // paramDict["page"] = "50"
        
        MCAWebServiceManager.sharedWebServiceManager.postRequest(requestParam:paramDict,
                                                                 endPoint:MCAAPIEndPoints.BrokerMatchedFundingProgramListEndPoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()
                
                let lendingProgram = response["lending_programs"]
                print("Lending program ---> \(lendingProgram)")
                
                let loanTerm = response["application"]["loan_term"].intValue
                let  loanTermMonths = (loanTerm / 30)
                let  loanTermString = "\(loanTermMonths) months"
                self.merchantApplicationDetails.loanTerm = loanTermString
                
                let fundingProgramArray =  lendingProgram.arrayValue
                
                
                for item in fundingProgramArray {
                    self.fundingProgram = MCAFundingProgram(data:item["lending_program"])
                    self.matchedFundingProgramList.append(self.fundingProgram)
                }
                
                //self.filterListWithSearchString(searchString: self.seacrhBar.searchTextField.text!)
                
                self.tableView.reloadData()
                
        },
              failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Unable to fetch Funding Programs", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
        
        
        
    }
    
    
    //MARK: TableView Datasource and Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return matchedFundingProgramList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if(indexPath.row == 0)
        {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "MCAFundingProgramDetailCell", for: indexPath) as! MCAFundingProgramDetailCell
            headerCell.delegate = self;
            headerCell.selectionStyle = .none
            headerCell.updateDataSource(merchantApplicationDetailObject: merchantApplicationDetails)
            headerCell.indexPath = indexPath as NSIndexPath!
            
            return headerCell;
        }
        
        
        let MatchedFPListTVCell = tableView.dequeueReusableCell(withIdentifier: "MCAMatchedFPListTVCell", for: indexPath) as! MCAMatchedFPListTVCell
        MatchedFPListTVCell.indexPath = indexPath as NSIndexPath!
        
        if !matchedFundingProgramList.isEmpty {
            MatchedFPListTVCell .updateDataSource(matchedFundingProgramObject: matchedFundingProgramList[indexPath.row - 1] )
        }
        
        
        MatchedFPListTVCell.delegate = self
        MatchedFPListTVCell.checkButton.tag = indexPath.row - 1
        MatchedFPListTVCell.selectionStyle = .none
        MatchedFPListTVCell.backgroundColor = UIColor.clear
        
        return MatchedFPListTVCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0)
        {
            return;
        }
        
        
        
        let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
        let applicationFormVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPApplicationFormVC") as! MCAFPApplicationFormVC
        applicationFormVC.fundingProgram = matchedFundingProgramList[indexPath.row - 1]
        navigationController?.pushViewController(applicationFormVC, animated: true)
        
        
    }
    
    func showDetailOfFundingProgram(matchedFP: MCAFundingProgram)
    {
        
        let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
        let applicationFormVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPApplicationFormVC") as! MCAFPApplicationFormVC
        applicationFormVC.fundingProgram = matchedFP
        navigationController?.pushViewController(applicationFormVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        if(indexPath.row == 0)
        {
            return 170;
        }
        return 259
    }
    
    @IBAction func infoButtonTapped(_ sender: Any){
        
        let TitleString = NSAttributedString(string:"Matched Funding Program with Merchant Application", attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Regular", size: 18.0), NSForegroundColorAttributeName : UIColor.black])
        let MessageString = NSAttributedString(string: NSLocalizedString("Matched Funding Program Info", comment: ""), attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Light", size: 12.0), NSForegroundColorAttributeName : UIColor.gray])
        
        let alertViewController = UIAlertController(title : "", message : "", preferredStyle : .alert)
        alertViewController.setValue(TitleString, forKey: "attributedTitle")
        alertViewController.setValue(MessageString, forKey: "attributedMessage")
        alertViewController.view.tintColor = ColorConstants.red
        
        
        
        alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
        present(alertViewController, animated: true , completion: nil)
        
    }
    
    func programSelected(buttonTag : Int)
    {
        let selectedProgram : MCAFundingProgram = matchedFundingProgramList[buttonTag]
        selectedProgram.isSelected = true
        selectedItemsCount = selectedItemsCount + 1
        selectedCountLabel.text = "\(selectedItemsCount)"
        
    }
    
    func programDeSelected(buttonTag : Int)
    {
        let deselectedProgram : MCAFundingProgram = matchedFundingProgramList[buttonTag]
        deselectedProgram.isSelected = false
        selectedItemsCount = selectedItemsCount - 1
        selectedCountLabel.text = "\(selectedItemsCount)"
        
    }
    
    
    
    
    func calculateFundingProgramSelectionCount()
    {
        
        selectedItemsCount = 0
        
        for matchedFundingProgram  in matchedFundingProgramList
        {
            if (matchedFundingProgram.isSelected == true)
            {
                
                selectedItemsCount = selectedItemsCount + 1
            }
        }
        selectedCountLabel.text = "\(selectedItemsCount)"
        tableView.reloadData()
    }
    
    
    
    @IBAction func clearButtonTapped()
    {
        for matchedFundingProgram  in matchedFPList!
        {
            (matchedFundingProgram as! MCAMatchedFundingProgram).isSelected = false
        }
        selectedItemsCount = 0
        selectedCountLabel.text = "0"
        tableView.reloadData()
        
    }
    
    
    
    @IBAction func referButtonTapped()
        
    {
        if selectedItemsCount == 0 {
            let TitleString = NSAttributedString(string:"", attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Regular", size: 18.0), NSForegroundColorAttributeName : UIColor.black])
            let MessageString = NSAttributedString(string: "Please choose any one or more Funding Program to refer", attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Light", size: 12.0), NSForegroundColorAttributeName : UIColor.black])
            
            let alertViewController = UIAlertController(title : "", message : "", preferredStyle : .alert)
            alertViewController.setValue(TitleString, forKey: "attributedTitle")
            alertViewController.setValue(MessageString, forKey: "attributedMessage")
            alertViewController.view.tintColor = ColorConstants.red
            
            
            
            alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
            present(alertViewController, animated: true , completion: nil)
            
        }
            
        else
        {
            
            if self.checkNetworkConnection() == false {
                return
            }
            
            self.showActivityIndicator()
            
            for matchedFundingProgram  in matchedFundingProgramList
            {
                if (matchedFundingProgram.isSelected == true)
                {
                    
                    let dict : [String:String] = ["interest_rate":matchedFundingProgram.buyRate,"lending_program_id":"\(matchedFundingProgram.funderId!)"]
                    selectedFundingPrograms.append(dict)                }
            }
            
            if selectedFundingPrograms.count == 0 {
                let TitleString = NSAttributedString(string:"Success!", attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Regular", size: 18.0), NSForegroundColorAttributeName : UIColor.black])
                let MessageString = NSAttributedString(string: "Please Select Funding Programs To Refer", attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Light", size: 12.0), NSForegroundColorAttributeName : UIColor.black])
                
                let alertViewController = UIAlertController(title : "", message : "", preferredStyle : .alert)
                alertViewController.setValue(TitleString, forKey: "attributedTitle")
                alertViewController.setValue(MessageString, forKey: "attributedMessage")
                alertViewController.view.tintColor = ColorConstants.red
                
                
                
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : { action in
                    
    }))
                
                self.present(alertViewController, animated: true , completion: nil)

            }
            
            else
            {

            
            var paramDict = Dictionary<String , Any>()
            
            paramDict["application_updates"] = ["application_id" : applicationId.description,"application_update":selectedFundingPrograms]
            
            //  paramDict["application_id"] = applicationId.description
            // paramDict["page"] = "50"
            
            MCAWebServiceManager.sharedWebServiceManager.postRequest(requestParam:paramDict,
                                                                     endPoint:MCAAPIEndPoints.BrokerReferMatchedFundingProgramEndPoint
                , successCallBack:{ (response : JSON) in
                    
                    self.stopActivityIndicator()
                    let TitleString = NSAttributedString(string:"Success!", attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Regular", size: 18.0), NSForegroundColorAttributeName : UIColor.black])
                    let MessageString = NSAttributedString(string: "The selected Funding Programs are referred to funder Successfully", attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Light", size: 12.0), NSForegroundColorAttributeName : UIColor.black])
                    
                    let alertViewController = UIAlertController(title : "", message : "", preferredStyle : .alert)
                    alertViewController.setValue(TitleString, forKey: "attributedTitle")
                    alertViewController.setValue(MessageString, forKey: "attributedMessage")
                    alertViewController.view.tintColor = ColorConstants.red
                    
                    
                    
                    alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : { action in
                        
                        let storyBoard = UIStoryboard(name: StoryboardName.MCAMerchantApplication, bundle: Bundle.main)
                        let applicationSummaryVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAMerchantApplicationSummaryVC) as! MCAMerchantApplicationSummaryVC
                        applicationSummaryVC.applicationState = self.applicationState
                        _ = self.navigationController?.popViewController(animated: true)
                        
                    }))
                    
                    self.present(alertViewController, animated: true , completion: nil)

                    
                    
                    
            },
                  failureCallBack: { (error : Error) in
                    
                    self.stopActivityIndicator()
                    print("Failure \(error)")
                    let alertViewController = UIAlertController(title : "MCAP", message : "Unable to fetch Funding Programs", preferredStyle : .alert)
                    alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                    self.present(alertViewController, animated: true , completion: nil)
                    
            })

            
            
                
            
        }
            
        }
        
    }
    
    func setUpsellRate(object : MCAFundingProgram)
    {
        
        addPicker(sender: object)
        
    }
    
    func setCommonRate(object: AnyObject)
    {
        addPickerForCommonRate(sender:object)
    }
    
    func addGradientToView()
    {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds;
        
        gradient.colors = [UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor,UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor,UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor]
        view.layer.addSublayer(gradient)
        
    }
 
    /*
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
    
   */
    
    func addPicker(sender : AnyObject) {
        pickerState = 1
        pickerTitle?.title = "Set Upsell Rate"
        self.navigationController?.navigationBar.isHidden = true
        
      
        fundingProgram = sender as! MCAFundingProgram
        let maxUpsellRate  = Int(fundingProgram.maxUpsellRate)
         rates = []
        for index in 0...maxUpsellRate! {
            rates.append("\(index)")
        }
        configPicker()

      self.view.addSubview(customPicker)

       // self.view.addSubview(self.toolbar!)
        
    }
    
    func addPickerForCommonRate(sender : AnyObject)
    {
        pickerState = 0
        self.navigationController?.navigationBar.isHidden = true
        indexPath = sender  as! NSIndexPath
        rates = []
        for index in 0...20 {
            rates.append("\(index)")
        }
        configPicker()

        self.view.addSubview(customPicker)
      //  self.view.addSubview(self.toolbar!)
        
    }
    
    func configPicker() {
        if(nil == customPicker)
        {
            customPicker =  Bundle.main.loadNibNamed("MCACustomPickerView", owner: self, options: nil)?[0] as! MCACustomPickerView
        }
        customPicker.selectedRange = 0
        customPicker.setDatasource(dataSource: rates)
       customPicker.pickerDelegate = self;
        customPicker.frame = self.view.bounds
        customPicker.layoutIfNeeded()
        
    }
    
    
    
    
    
 /*
    func inputToolbarDonePressed() {
        self.navigationController?.navigationBar.isHidden = false
        
        self.upsellRatePicker.removeFromSuperview()
        self.toolbar?.removeFromSuperview()
        self.didItemSelected(object:fundingProgram)
    }
 
    func didItemSelected(object:MCAFundingProgram)
    {
        
        if pickerState == 0
        {
            let cell = tableView.cellForRow(at: indexPath as IndexPath ) as! MCAFundingProgramDetailCell
            let selectedString = rates[self.upsellRatePicker.selectedRow(inComponent: 0)] as String
            cell.commonRateButton .setTitle(selectedString, for: UIControlState.normal)
            
        }
        else
        {
            let selectedString = rates[self.upsellRatePicker.selectedRow(inComponent: 0)] as String
            object.maxUpsellRate = selectedString as String?
            tableView.reloadData()
        }
    }
  */
    func pickerSelected(dealsPipelineRange : NSInteger)
    {
        self.navigationController?.navigationBar.isHidden = false

        
        if pickerState == 0
        {
            let cell = tableView.cellForRow(at: indexPath as IndexPath ) as! MCAFundingProgramDetailCell
            let selectedString = rates[dealsPipelineRange]
            cell.commonRateButton .setTitle(selectedString, for: UIControlState.normal)
                for matchedFundingProgram  in matchedFundingProgramList
                {
                    if selectedString <= matchedFundingProgram.maxUpsellRate! {

                  matchedFundingProgram.upsellRate = matchedFundingProgram.maxUpsellRate
                    }
                    else{
                        matchedFundingProgram.upsellRate = selectedString

                    }
                }
                tableView.reloadData()
            }
                   else{
        let selectedString = rates[dealsPipelineRange]
        fundingProgram.upsellRate = selectedString as String?
        tableView.reloadData()
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
