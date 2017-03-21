//
//  MCAMatchedFundingProgramVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 08/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMatchedFundingProgramVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource,MatchedFundingProgramCellDelegate,MatchedFundingProgramDetailCellDelegate,GenericPopUpDelegate,UIPickerViewDataSource,UIPickerViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedCountLabel : UILabel!
    
    var upsellRatePicker = UIPickerView()
    var blurView:UIVisualEffectView!

    var headerView : MCAMatchedFPHeaderView!
    var toolbar : UIToolbar?
    var doneButton : UIBarButtonItem?


    var indexPath: NSIndexPath!
    
    var applicationState: Int!

    
    var dataDataSource = ["The Jewellery Shop", "Stacy's Boutique", "Miami Florists", "Food Truck", "Sport's World"]
    var rates = ["01","02","03","04","05","06","07","08","09"]

    var matchedFPList : NSMutableArray!
    
    var matchedFundingProgram : MCAMatchedFundingProgram!
    var selectedItemsCount = 0;
    

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"iconInfo"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.rightBarButtonclicked))
        
         configPicker()
        initilazeToolBar()


}
    
    func rightBarButtonclicked()
    {
        let TitleString = NSAttributedString(string:"Matched Funding Program with Merchant Application", attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Regular", size: 18.0), NSForegroundColorAttributeName : UIColor.black])
        let MessageString = NSAttributedString(string: "Based on the details provided by the merchant you can prepare a list of funding programs.Click the checkbox to select one or multiple funding programs for the merchant.After selecting the desired funding programs,click the Refer to Merchant button at the bottom of the screen.", attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Light", size: 12.0), NSForegroundColorAttributeName : UIColor.gray])
        
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
        for _   in dataDataSource
        {
            matchedFundingProgram = MCAMatchedFundingProgram(data:nil)
            matchedFPList? .add(matchedFundingProgram)
        }
        
        self.title = "Matched Funding Programs"
        tableView.register(UINib(nibName: "MCAMatchedFPListTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAMatchedFPListTVCell")
        

        tableView.register(UINib(nibName: "MCAMatchedFPHeaderView", bundle: Bundle.main), forCellReuseIdentifier: "MCAFundingProgramDetailCell")

        
        tableView.tableFooterView = UIView()
        
        tableView.reloadData()

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
    
    //MARK: TableView Datasource and Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      return matchedFPList.count + 1
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
        
        MatchedFPListTVCell .updateDataSource(matchedFundingProgramObject: matchedFPList?.object(at: indexPath.row - 1) as! MCAMatchedFundingProgram)
        
        
        let matchedFundingPgm = matchedFPList?.object(at: indexPath.row - 1) as! MCAMatchedFundingProgram;
        
        if(false == matchedFundingPgm.showDetails)
        {
            MatchedFPListTVCell.detailButton.setImage(UIImage(named: "iconArrowRight"), for: UIControlState.normal)
        }
        else
        {
            MatchedFPListTVCell.detailButton.setImage(UIImage(named: "iconArrowDown"), for: UIControlState.normal)
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
//        let matchedFP  = matchedFPList?.object(at: indexPath.row > 0 ? indexPath.row  - 1 : 0) as! MCAMatchedFundingProgram
//        if(true == matchedFP.showDetails)
//        {
//            return 259
//        }
        
        return 259
    }
    
    @IBAction func infoButtonTapped(_ sender: Any){
        
        let TitleString = NSAttributedString(string:"Matched Funding Program with Merchant Application", attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Regular", size: 18.0), NSForegroundColorAttributeName : UIColor.black])
        let MessageString = NSAttributedString(string: "Based on the details provided by the merchant you can prepare a list of funding programs.Click the checkbox to select one or multiple funding programs for the merchant.After selecting the desired funding programs,click the Refer to Merchant button at the bottom of the screen.", attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Light", size: 12.0), NSForegroundColorAttributeName : UIColor.gray])
        
        let alertViewController = UIAlertController(title : "", message : "", preferredStyle : .alert)
        alertViewController.setValue(TitleString, forKey: "attributedTitle")
        alertViewController.setValue(MessageString, forKey: "attributedMessage")
        alertViewController.view.tintColor = ColorConstants.red
        

        
        alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
        present(alertViewController, animated: true , completion: nil)

    }
    
    func programSelected(buttonTag : Int)
    {
        let selectedProgram : MCAMatchedFundingProgram = matchedFPList! .object(at: buttonTag) as! MCAMatchedFundingProgram
        selectedProgram.isSelected = true
        selectedItemsCount = selectedItemsCount + 1
        selectedCountLabel.text = "\(selectedItemsCount)"

        
    }
    
    func programDeSelected(buttonTag : Int)
    {
        let deselectedProgram : MCAMatchedFundingProgram = matchedFPList! .object(at: buttonTag) as! MCAMatchedFundingProgram
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
    
    func setUpsellRate(object : AnyObject)
    {
        
    addPicker(sender: object)
        
    }
    
    func setCommonRate(object: AnyObject)
    {
        addPicker(sender: object)
        
    }
    
   
    func blur() {
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.isUserInteractionEnabled = false
        self.view.addSubview(blurView)
        blurView.frame = self.view.bounds
    }
    
    func unblur() {
        self.blurView.removeFromSuperview()
    }
    
    
    func addPicker(sender : AnyObject) {
        self.blur()
        indexPath = sender as! IndexPath as NSIndexPath!
        self.view.addSubview(self.upsellRatePicker)
       self.view.addSubview(self.toolbar!)
        
    }
    
    func configPicker() {
        upsellRatePicker.alpha = 1.0
        upsellRatePicker.backgroundColor = UIColor.white
        self.upsellRatePicker.delegate = self
        self.upsellRatePicker.dataSource = self
        
        let viewFrame = self.view.frame;
        let pickerHeight = self.upsellRatePicker.frame.size.height;
        let pickerFrame = CGRect(x:0.0, y: viewFrame.size.height/2-pickerHeight/2,
                                 width: viewFrame.size.width, height: pickerHeight);
        self.upsellRatePicker.frame = pickerFrame;
        self.upsellRatePicker.tintColor = UIColor.white
        
    }
    
    
    func initilazeToolBar() {
        toolbar = UIToolbar()
        toolbar?.barStyle = .blackTranslucent
        toolbar?.isTranslucent = true
        toolbar?.sizeToFit()
        toolbar?.backgroundColor = ColorConstants.red
        
        doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.inputToolbarDonePressed))
        doneButton?.tintColor = .white
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar?.setItems([flexibleSpaceButton, doneButton!], animated: false)
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rates[row]
    }
    
    
    
    func inputToolbarDonePressed() {
        unblur()
        self.upsellRatePicker.removeFromSuperview()
        self.toolbar?.removeFromSuperview()
        self.didItemSelected(object: indexPath)
    }
    
    func didItemSelected(object:AnyObject)
    {
        
        let indexPath =  object
        if indexPath.row == 0
        {
            let cell = tableView.cellForRow(at: indexPath as! IndexPath ) as! MCAFundingProgramDetailCell
            let selectedString = rates[self.upsellRatePicker.selectedRow(inComponent: 0)] as String
            cell.commonRateButton .setTitle(selectedString, for: UIControlState.normal)
            
        }
        else{
        let cell = tableView.cellForRow(at: indexPath as! IndexPath) as! MCAMatchedFPListTVCell
        let selectedString = rates[self.upsellRatePicker.selectedRow(inComponent: 0)] as String
        cell.upsellRateButton .setTitle(selectedString, for: UIControlState.normal)
        
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
