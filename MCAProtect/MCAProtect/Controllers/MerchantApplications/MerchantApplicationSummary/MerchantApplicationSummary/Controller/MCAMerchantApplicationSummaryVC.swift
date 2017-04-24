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
    
    var merchantApplicationDetail : MCAMerchantApplicationDetail!

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
        if nil != merchantApplicationDetail{
            return merchantApplicationDetail.fieldCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        switch indexPath.row
        {
            case MASummaryKeys.businessName.hashValue:
                let   summaryCell =   tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
                summaryCell.delegate = self
                switch applicationState {
                    case ApplicationState.New.rawValue:
                        summaryCell.rightBackButton.isHidden = false
                        summaryCell.viewDetailsButtonTrailingConstant.constant = -18
                    case ApplicationState.UnderWriting.rawValue:
                        fallthrough
                    case ApplicationState.NeedMoreStips.rawValue:
                        summaryCell.viewDetailsButton.isHidden = false
                        summaryCell.rightBackButton.isHidden = false
                        summaryCell.viewDetailsButtonTrailingConstant.constant = 38
                        summaryCell.viewDetailsButton.setImage(UIImage(named:"iconSubmit"), for: .normal)
                    case ApplicationState.DNQ.rawValue: fallthrough
                    case ApplicationState.Funded.rawValue: fallthrough
                    case ApplicationState.Lost.rawValue: fallthrough
                    case ApplicationState.Renewal.rawValue:
                        summaryCell.rightBackButton.isHidden = false
                        summaryCell.viewDetailsButtonTrailingConstant.constant = -18
                    
                    default:break
                }
                summaryCell.setMerchantApplicationSummary(merchantSummary: merchantApplicationDetail, merchantSummaryKey: MASummaryKeys.businessName)
                cell = summaryCell

            case MASummaryKeys.contactName.hashValue:
                let   summaryCell =   tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
                summaryCell.delegate = self
                summaryCell.setMerchantApplicationSummary(merchantSummary: merchantApplicationDetail, merchantSummaryKey: MASummaryKeys.contactName)
                cell = summaryCell

            case MASummaryKeys.loanAmount.hashValue:
                let   summaryCell =   tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
                summaryCell.delegate = self
                summaryCell.setMerchantApplicationSummary(merchantSummary: merchantApplicationDetail, merchantSummaryKey: MASummaryKeys.loanAmount)

                cell = summaryCell

            case MASummaryKeys.email.hashValue:
                
                
                let   emailCell =   tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAEmailTableViewCell, for: indexPath) as! MCAEmailTableViewCell
                emailCell.delegate = self
                
                emailCell.setMerchantApplicationSummary(merchantSummary: merchantApplicationDetail, merchantSummaryKey: MASummaryKeys.email)
                cell = emailCell
            
            case MASummaryKeys.telephone.hashValue:

                let   phoneNumberCell =   tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAPhoneNumberTableViewCell, for: indexPath) as! MCAPhoneNumberTableViewCell
                phoneNumberCell.delegate = self
                
                phoneNumberCell.setMerchantApplicationSummary(merchantSummary: merchantApplicationDetail, merchantSummaryKey: MASummaryKeys.telephone)
                cell = phoneNumberCell
            case MASummaryKeys.offeredOn.hashValue:
                let   summaryCell =   tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
                summaryCell.delegate = self
                summaryCell.setMerchantApplicationSummary(merchantSummary: merchantApplicationDetail, merchantSummaryKey: MASummaryKeys.offeredOn)
                cell = summaryCell

            default: break
        }
       
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    //MARK: - Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
           let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let applicationFormVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAApplicationFormVC) as! MCAApplicationFormVC
            applicationFormVC.titleText = self.merchantApplicationDetail.businessName
            applicationFormVC.applicationId = self.merchantApplicationDetail.applicationID
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
        applicationFormVC.applicationId = self.merchantApplicationDetail.applicationID
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
                submitStipulationsVC.merchantApplicationDetail = merchantApplicationDetail
                navigationController?.pushViewController(submitStipulationsVC, animated: true)
            default:
                break
        }
    }

}
