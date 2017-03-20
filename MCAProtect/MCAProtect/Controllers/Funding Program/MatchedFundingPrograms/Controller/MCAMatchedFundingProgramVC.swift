//
//  MCAMatchedFundingProgramVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 08/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMatchedFundingProgramVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource,MatchedFundingProgramCellDelegate,GenericPopUpDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedCountLabel : UILabel!
    @IBOutlet weak var setCommonRateButton : UIButton!
    var headerView : MCAMatchedFPHeaderView!
    
    var applicationState: Int!

    
    var dataDataSource = ["The Jewellery Shop", "Stacy's Boutique", "Miami Florists", "Food Truck", "Sport's World"]
    var matchedFPList : NSMutableArray!
    
    var matchedFundingProgram : MCAMatchedFundingProgram!
    var selectedItemsCount = 0;
    

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"iconInfo"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.rightBarButtonclicked))

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      return matchedFPList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if(indexPath.row == 0)
        {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "MCAFundingProgramDetailCell", for: indexPath) as! MCAFundingProgramDetailCell
            
            headerCell.contentView.backgroundColor = UIColor.red
            return headerCell;
        }
        
        
        let MatchedFPListTVCell = tableView.dequeueReusableCell(withIdentifier: "MCAMatchedFPListTVCell", for: indexPath) as! MCAMatchedFPListTVCell
        
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
        
        if(true == matchedFP.showDetails)
        {
            matchedFP.showDetails = false;
        }
        else
        {
            matchedFP.showDetails = true;
        }
        
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {

        if(indexPath.row == 0)
        {
            return 170;
        }
        let matchedFP  = matchedFPList?.object(at: indexPath.row > 0 ? indexPath.row  - 1 : 0) as! MCAMatchedFundingProgram
        if(true == matchedFP.showDetails)
        {
            return 330
        }
        
        return 60
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
    
    @IBAction func setCommonRateTapped()
    {
        
        let storyBoard = UIStoryboard(name: StoryboardName.MCAGenericPopUp, bundle: Bundle.main)
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: "MCAGenericPopViewController") as! MCAGenericPopViewController
        popUpVC.popUpDelegate = self
        navigationController?.present(popUpVC, animated: true, completion: nil)
        
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
    
    
    func didItemSelected(object:AnyObject)
    {
        
        setCommonRateButton .setTitle(object as? String, for: UIControlState.normal)
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
