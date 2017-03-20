//
//  MCAMerchantApplicationSummaryVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/3/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMerchantApplicationSummaryVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource,MCAApplicationSummaryTVCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var matchFundingProgramButton : UIButton!
    @IBOutlet weak var copyApplicationButton : UIButton!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    var titleText: String?
    var applicationState: Int!
    
    
    var dataSourceKeys = ["Business Name","Contact Name","Loan Amount","Email","Telephone","Offered on"]
    var dataSourceValues = ["Miami Florists","Christian A","$75,000","chirstian.a@gmail.com","(123) 876 -876","2017-01-21"]
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleText

        tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCAApplicationSummaryTVCell)
        tableView.register(UINib(nibName: "MCAEmailTableViewCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCAEmailTableViewCell)
        tableView.register(UINib(nibName: "MCAPhoneNumberTableViewCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCAPhoneNumberTableViewCell)

        tableView.tableFooterView = UIView()
        let contentInset:UIEdgeInsets = UIEdgeInsets(top: 60.0,left: 0,bottom: 0,right: 0);
        tableView.contentInset = contentInset
        
        matchFundingProgramButton.titleEdgeInsets =  UIEdgeInsetsMake(0.0, 20.0, 0.0, 0.0);
        matchFundingProgramButton.imageEdgeInsets =   UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0);
        copyApplicationButton.titleEdgeInsets =  UIEdgeInsetsMake(0.0, 20.0, 0.0, 0.0);
        copyApplicationButton.imageEdgeInsets =   UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0);
        
        
       

        switch applicationState {
        case ApplicationState.NeedMoreStips.rawValue:
            tableViewBottomConstraint.constant = 0
        default:
            break
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        
        if dataSourceKeys[indexPath.row] == "Email" {
             let   emailCell =   tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAEmailTableViewCell, for: indexPath) as! MCAEmailTableViewCell
            emailCell.titleLabel.text = dataSourceKeys[indexPath.row]
            emailCell.emailButton .setTitle(dataSourceValues[indexPath.row], for: UIControlState.normal)
            
            emailCell.delegate = self
            cell = emailCell
        }
        else if dataSourceKeys[indexPath.row] == "Telephone"
        {
            let   phoneNumberCell =   tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAPhoneNumberTableViewCell, for: indexPath) as! MCAPhoneNumberTableViewCell
            phoneNumberCell.titleLabel.text = dataSourceKeys[indexPath.row]
            phoneNumberCell.phoneNumberButton .setTitle(dataSourceValues[indexPath.row], for: UIControlState.normal)
            phoneNumberCell.delegate = self
            cell = phoneNumberCell
 
        }
        else
        {
      
 let   summaryCell =   tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
        summaryCell.titleLabel.text = dataSourceKeys[indexPath.row]
        summaryCell.dataTF.text = dataSourceValues[indexPath.row]
        summaryCell.delegate = self
            
            
            switch applicationState {
            case ApplicationState.UnderWriting.rawValue:
                fallthrough
            case ApplicationState.NeedMoreStips.rawValue:
                if indexPath.row == 0 {
                    summaryCell.viewDetailsButton.isHidden = false
                }
            default:
                break
            }
            
            if  (indexPath.row == 0) {
                summaryCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }
            else
            {
                summaryCell.accessoryType = UITableViewCellAccessoryType.none
            }
            

            cell = summaryCell
        }
        
       
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
           let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let applicationFormVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAApplicationFormVC) as! MCAApplicationFormVC
            navigationController?.pushViewController(applicationFormVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    @IBAction func copyApplicationButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
        let applicationFormVC = storyBoard.instantiateViewController(withIdentifier:VCIdentifiers.MCAApplicationFormVC) as! MCAApplicationFormVC
        applicationFormVC.applicationStatus = ApplicationStatus.CopyApplication.rawValue
        navigationController?.pushViewController(applicationFormVC, animated: true)
    }
    
    @IBAction func viewMatchedFundingProgramTapped(_ sender: Any)
    {
        let storyBoard = UIStoryboard(name: StoryboardName.MCAMatchedFundingProgram, bundle: Bundle.main)
        let matchedFundingProgramVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAMatchedFundingProgramVC) as! MCAMatchedFundingProgramVC
        matchedFundingProgramVC.applicationState = self.applicationState
        navigationController?.pushViewController(matchedFundingProgramVC, animated: true)
        
    }
    
    
    func rightActionButtonTapped() {
        switch applicationState {
        case ApplicationState.UnderWriting.rawValue:
            fallthrough
        case ApplicationState.NeedMoreStips.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCAMerchantApplication, bundle: Bundle.main)
            let submitStipulationsVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAMASubmitStipulationsVC) as! MCAMASubmitStipulationsVC
            navigationController?.pushViewController(submitStipulationsVC, animated: true)
        default:
            break
        }

    }

}
