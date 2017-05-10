//
//  MCAMerchantApplicationSummaryVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 10/05/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMerchantApplicationSummaryVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var matchFundingProgramButton : UIButton!
    @IBOutlet weak var copyApplicationButton : UIButton!
    var appSummary : MCASavedApplication!


    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadUI() {
        
        self.title = appSummary.applicationName
        tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCAApplicationSummaryTVCell)
        tableView.tableFooterView = UIView()
        
        matchFundingProgramButton.titleEdgeInsets =  UIEdgeInsetsMake(0.0, 20.0, 0.0, 0.0);
        matchFundingProgramButton.imageEdgeInsets =   UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0);
        copyApplicationButton.titleEdgeInsets =  UIEdgeInsetsMake(0.0, 20.0, 0.0, 0.0);
        copyApplicationButton.imageEdgeInsets =   UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0);

      //  matchFundingProgramButton.layer.cornerRadius = 5.0
      //  copyApplicationButton.layer.cornerRadius = 5.0
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        switch indexPath.row
        {
        case ApplicationSummaryKeys.SASummarySubmittedOn.hashValue:
            cell.setSavedApplicationSummary(appSummary: appSummary, appSummaryKey: ApplicationSummaryKeys.SASummarySubmittedOn)
            
        case ApplicationSummaryKeys.SASummaryNeedeIn.hashValue:
            cell.setSavedApplicationSummary(appSummary: appSummary, appSummaryKey: ApplicationSummaryKeys.SASummaryNeedeIn)
            
        case ApplicationSummaryKeys.SASummaryBusinessName.hashValue:
            cell.setSavedApplicationSummary(appSummary: appSummary, appSummaryKey: ApplicationSummaryKeys.SASummaryBusinessName)
            cell.rightBackButton.isHidden = false
            cell.viewDetailsButtonTrailingConstant.constant = -18
            
        case ApplicationSummaryKeys.SASummaryLoanValue.hashValue:
            cell.setSavedApplicationSummary(appSummary: appSummary, appSummaryKey: ApplicationSummaryKeys.SASummaryLoanValue)
            
        default: break;
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let applicationFormVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAApplicationFormVC) as! MCAApplicationFormVC
            applicationFormVC.savedApplication = appSummary
            applicationFormVC.applicationId = appSummary.applicationId
            applicationFormVC.titleText = appSummary.applicationName
            navigationController?.pushViewController(applicationFormVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    
    @IBAction func viewMatchedFundingProgramTapped(_ sender: Any)
    {
        let storyBoard = UIStoryboard(name: StoryboardName.MCAMatchedFundingProgram, bundle: Bundle.main)
        let matchedFundingProgramVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAMatchedFundingProgramVC) as! MCAMatchedFundingProgramVC
        matchedFundingProgramVC.applicationId = appSummary.applicationId
        matchedFundingProgramVC.merchantApplicationDetails = self.appSummary
        
        navigationController?.pushViewController(matchedFundingProgramVC, animated: true)
    }
    
    @IBAction func copyApplicationButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
        let applicationFormVC = storyBoard.instantiateViewController(withIdentifier:VCIdentifiers.MCAApplicationFormVC) as! MCAApplicationFormVC
        applicationFormVC.applicationStatus = ApplicationStatus.CopyApplication.rawValue
        applicationFormVC.applicationId = appSummary.applicationId
        navigationController?.pushViewController(applicationFormVC, animated: true)
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
