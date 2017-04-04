//
//  MCAOwnerAndLocationDetailsVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/1/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASAOwnerAndLocationDetailsVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var dataSourceArray : [AnyObject] = []
    
    var applicaionDetailType: NSInteger!
    var applicationStatus : Int?
    
    var ownerInformation : MCAOwnerInformation!
    var ownerInformationArray : [MCAOwnerInformation]!
    
    var businessLocation : MCABusinessLocationList!
    var businessLocationArray : [MCABusinessLocationList]!
    var loanApplication : MCALoanApplication!
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch applicaionDetailType {
            
            case SavedApplicationForm.OwnerOrOfficerInformation.rawValue:
                self.title = "Owner Information"
                ownerInformationArray = loanApplication.ownersInfo                
                dataSourceArray = ownerInformationArray
                
            case SavedApplicationForm.BusinessLocation.rawValue:
                self.title = "Business Location"
                businessLocationArray = loanApplication.businessFinance.businessLocationsList
                dataSourceArray = businessLocationArray
                
            default: break
        }
        
        tableView.register(UINib(nibName: "MCASAOwnerAndLocationDetailsTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAOwnerAndLocationDetailsTVCell)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(
            animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAOwnerAndLocationDetailsTVCell, for: indexPath) as! MCASAOwnerAndLocationDetailsTVCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear

        switch applicaionDetailType {
            case SavedApplicationForm.OwnerOrOfficerInformation.rawValue:
                ownerInformation = dataSourceArray[indexPath.row] as! MCAOwnerInformation
                cell.setOwnerInformation(ownerInformation: ownerInformation)
            case SavedApplicationForm.BusinessLocation.rawValue:
                businessLocation = businessLocationArray[indexPath.row] 
                cell.setBusinessLocation(businessLocation: businessLocation)
            default : break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCASAOwnerAndLocationDetailsTVCell
        selectedCell.selectedView.isHidden = false
        selectedCell.backgroundColor = ColorConstants.selectedBackground
        
        if applicaionDetailType == SavedApplicationForm.BusinessLocation.rawValue {
            
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let businessLocationDetailsVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCASABusinessLocationDetails) as! MCASABusinessLocationDetails
            businessLocation = dataSourceArray[indexPath.row] as! MCABusinessLocationList
            businessLocationDetailsVC.businessLocationName = businessLocation.locationName
            businessLocationDetailsVC.applicationStatus = applicationStatus
            navigationController?.pushViewController(businessLocationDetailsVC, animated: true)
        }
        else if applicaionDetailType == SavedApplicationForm.OwnerOrOfficerInformation.rawValue {
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let ownerInformationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCASAOwnerInformationDetailVC) as! MCASAOwnerInformationDetailVC
            ownerInformation = dataSourceArray[indexPath.row] as! MCAOwnerInformation
            ownerInformationDetailVC.ownerName = ownerInformation.ownerName
            ownerInformationDetailVC.applicationStatus = applicationStatus
            navigationController?.pushViewController(ownerInformationDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCASAOwnerAndLocationDetailsTVCell
        deselectedCell.selectedView.isHidden = true
        deselectedCell.backgroundColor = ColorConstants.background
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
}
