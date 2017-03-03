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
    
    let ownerDSArray = ["Randell D'souza","Angela Merkel","William Jebor"]
    let ownerDSValueArray  = ["666346173","666552699","666023487"]
    
    let businessDSArray = ["Business Location 1","Business Location 2","Business Location 3","Business Location 4","Business Location 5"]
    let businessDSValueArray  = ["Columbiana Country","Alexander City","Birmingham","HeadLand","Montgomery"]
    
    var dataSourceArray : [String] = []
    var dataSourceValueArray : [String] = []
    
    var applicaionDetailType: NSInteger!

    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MCASAOwnerAndLocationDetailsTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAOwnerAndLocationDetailsTVCell)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(
            animated)
        switch applicaionDetailType {
            
        case SavedApplicationForm.OwnerOrOfficerInformation.rawValue:
            self.title = "Owner Information"
            dataSourceArray = ownerDSArray
            dataSourceValueArray = ownerDSValueArray
        case SavedApplicationForm.BusinessLocation.rawValue:
            self.title = "Business Location"
            dataSourceArray = businessDSArray
            dataSourceValueArray = businessDSValueArray

        default:
            break
        }
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
        
        cell.headingLabel.text = dataSourceArray[indexPath.row]
        cell.detailLabel.text = dataSourceValueArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCASAOwnerAndLocationDetailsTVCell
        selectedCell.selectedView.isHidden = false
        selectedCell.backgroundColor = ColorConstants.selectedBackground
        
        if applicaionDetailType == SavedApplicationForm.BusinessLocation.rawValue {
            
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let businessLocationDetailsVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCASABusinessLocationDetails) as! MCASABusinessLocationDetails
            businessLocationDetailsVC.businessLocationName = businessDSArray[indexPath.row]
            navigationController?.pushViewController(businessLocationDetailsVC, animated: true)
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
