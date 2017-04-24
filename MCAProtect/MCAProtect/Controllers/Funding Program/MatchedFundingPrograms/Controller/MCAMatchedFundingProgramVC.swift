//
//  MCAMatchedFundingProgramVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 08/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAMatchedFundingProgramVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource,MatchedFundingProgramCellDelegate,MatchedFundingProgramDetailCellDelegate,UIPickerViewDataSource,UIPickerViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedCountLabel : UILabel!
    
    var upsellRatePicker = UIPickerView()
    var blurView:UIVisualEffectView!

    var headerView : MCAMatchedFPHeaderView!
    var toolbar : UIToolbar?
    var doneButton : UIBarButtonItem?
    var pickerTitle : UIBarButtonItem?


    var indexPath: NSIndexPath!
    
    var applicationState: Int!
    var pickerState: Int!
    var applicationId       : Int!


    
       var rates = ["01","02","03","04","05","06","07","08","09"]

    var matchedFPList : NSMutableArray!
    
    var matchedFundingProgram : MCAMatchedFundingProgram!
    var merchantApplicationDetails :   MCAMerchantApplicationDetail!
    var fundingProgram : MCAFundingProgram!
    var matchedFundingProgramList = [MCAFundingProgram]()
    var selectedItemsCount = 0;
    

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"iconInfo"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.rightBarButtonclicked))
         configPicker()
      //  upsellRatePicker.setma
        initilazeToolBar()


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
        matchedFPList  = NSMutableArray.init()
        
        for _   in 1...5
        {
            matchedFundingProgram = MCAMatchedFundingProgram(data:nil)
            matchedFPList? .add(matchedFundingProgram)
        }
        
        self.title = NSLocalizedString("Matched funding Program title", comment: "")
        tableView.register(UINib(nibName: "MCAMatchedFPListTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAMatchedFPListTVCell")
        tableView.register(UINib(nibName: "MCAMatchedFPHeaderView", bundle: Bundle.main), forCellReuseIdentifier: "MCAFundingProgramDetailCell")
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        getMatchedFundingProgramList()

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
            headerCell.indexPath = indexPath as NSIndexPath!

            return headerCell;
        }
        
        
        let MatchedFPListTVCell = tableView.dequeueReusableCell(withIdentifier: "MCAMatchedFPListTVCell", for: indexPath) as! MCAMatchedFPListTVCell
        MatchedFPListTVCell.indexPath = indexPath as NSIndexPath!
        
        if !matchedFundingProgramList.isEmpty {
            MatchedFPListTVCell .updateDataSource(matchedFundingProgramObject: matchedFundingProgramList[indexPath.row - 1] )
        }
        
        
      //  let matchedFundingPgm = matchedFPList?.object(at: indexPath.row - 1) as! MCAMatchedFundingProgram;
        
        
//        if(indexPath.row % 2 == 0)
//        {
//            matchedFundingPgm.logoImgName = "Funding Logo 11.png"
//            matchedFundingPgm.funderName = "Snap Advances"
//
//        }
//        else
//        {
//            matchedFundingPgm.logoImgName = "greenBox.png"
//            matchedFundingPgm.funderName = "Greenbox Capital"
//        }

        
           
        MatchedFPListTVCell.delegate = self
        MatchedFPListTVCell.checkButton.tag = indexPath.row - 1
        MatchedFPListTVCell.selectionStyle = .none
        MatchedFPListTVCell.backgroundColor = UIColor.clear
        //MatchedFPListTVCell.titleLabel.text = matchedFundingPgm.funderName as String?;
       // MatchedFPListTVCell.logoImgView.image = UIImage(named: matchedFundingPgm.logoImgName as! String)
        
        return MatchedFPListTVCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0)
        {
            return;
        }
        
        
        
        let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
        let underwritingMerchantVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPApplicationFormVC") as! MCAFPApplicationFormVC
        navigationController?.pushViewController(underwritingMerchantVC, animated: true)

        
    }
    
    func showDetailOfFundingProgram(matchedFP: MCAMatchedFundingProgram)
    {
        
        let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
        let underwritingMerchantVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPApplicationFormVC") as! MCAFPApplicationFormVC
        navigationController?.pushViewController(underwritingMerchantVC, animated: true)
        
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

        for matchedFundingProgram  in matchedFPList!
        {
            if ((matchedFundingProgram as! MCAMatchedFundingProgram).isSelected == true)
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

            present(alertViewController, animated: true , completion: nil)

            
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
    
    
    func addPicker(sender : AnyObject) {
        pickerState = 1
        pickerTitle?.title = "Set Upsell Rate"
        self.navigationController?.navigationBar.isHidden = true

        self.blur()
        fundingProgram = sender as! MCAFundingProgram
        self.view.addSubview(self.upsellRatePicker)
        self.view.addSubview(self.toolbar!)
        
    }
    
    func addPickerForCommonRate(sender : AnyObject)
    {
        pickerState = 0
        self.navigationController?.navigationBar.isHidden = true

        pickerTitle?.title = "Set Common Rate"
        self.blur()

        indexPath = sender  as! NSIndexPath
        self.view.addSubview(self.upsellRatePicker)
        self.view.addSubview(self.toolbar!)

    }
    
    func configPicker() {
        upsellRatePicker.alpha = 1.0
      //  upsellRatePicker.backgroundColor = UIColor.white
        self.upsellRatePicker.delegate = self
        self.upsellRatePicker.dataSource = self
        
        let viewFrame = self.view.frame;
        let pickerHeight = self.upsellRatePicker.frame.size.height;
        let pickerFrame = CGRect(x:0.0, y: viewFrame.size.height-pickerHeight,
                                 width: viewFrame.size.width, height: pickerHeight);
        self.upsellRatePicker.frame = pickerFrame;
        self.upsellRatePicker.tintColor = UIColor.white
        
    }
    
    
    func initilazeToolBar() {
        toolbar = UIToolbar()
        toolbar?.isTranslucent = false
        toolbar?.barTintColor = UIColor.darkGray
        toolbar?.sizeToFit()
       
        doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.inputToolbarDonePressed))
        doneButton?.tintColor = .white
        
        
        let fixed = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: self, action: nil)
        fixed.width = 10
        
        pickerTitle = UIBarButtonItem(title: "Set Upsell Rate", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        pickerTitle?.setTitleTextAttributes([NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Medium", size: 18.0),
            NSForegroundColorAttributeName : UIColor.white], for: UIControlState.normal)
               let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar?.setItems([fixed,pickerTitle!,flexibleSpaceButton, doneButton!], animated: false)
        toolbar?.isUserInteractionEnabled = true
    

        toolbar?.frame = CGRect(x:0,
                                y:    self.upsellRatePicker.frame.origin.y - 44, // right under the picker
            width:self.upsellRatePicker.frame.width, // make them the same width
            height:44)
        

        
    }

    
    //MARK: - PickerView Datasource and Delegates
  
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
 {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return rates.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return rates[row]
//    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let strTitle = rates[row]
        let attString = NSAttributedString(string: strTitle, attributes: [NSForegroundColorAttributeName : ColorConstants.red])
        return attString
    }
    
    
    func inputToolbarDonePressed() {
        unblur()
        self.navigationController?.navigationBar.isHidden = false

        self.upsellRatePicker.removeFromSuperview()
        self.toolbar?.removeFromSuperview()
        self.didItemSelected(object:matchedFundingProgram)
    }
    
    func didItemSelected(object:MCAMatchedFundingProgram)
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
            object.upsellRate = selectedString as NSString?
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
