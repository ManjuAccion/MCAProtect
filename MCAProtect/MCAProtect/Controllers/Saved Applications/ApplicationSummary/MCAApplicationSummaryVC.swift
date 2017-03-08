//
//  MCAApplicationSummaryVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAApplicationSummaryVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resumeApplicationButton: UIButton!
    @IBOutlet weak var copyApplicationButton: UIButton!
    
    var dataSourceKeys = ["Submitted on","Business Name","Needed in","Loan Value"]
    var dataSourceValues = ["10 Days ago","Miami Florists","3 Days","$60000"]

    var dataSourceArray : [String] = []
    var titleText: String?
    
    //MARK: - View Life Cycle
    
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
        
        self.title = titleText
        tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCAApplicationSummaryTVCell)
        tableView.tableFooterView = UIView()
        resumeApplicationButton.layer.cornerRadius = 5.0
        copyApplicationButton.layer.cornerRadius = 5.0
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
        
        cell.selectionStyle = .none
        cell.titleLabel.text = dataSourceKeys[indexPath.row]
        cell.dataTF.text = dataSourceValues[indexPath.row]
        cell.backgroundColor = UIColor.clear
        if indexPath.row == 1 {
            cell.accessoryType = UITableViewCellAccessoryType.detailDisclosureButton;
        }
        
        if indexPath.row == 1 {
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let storyBoard = UIStoryboard(name: "SavedApplication", bundle: Bundle.main)
            let applicationFormVC = storyBoard.instantiateViewController(withIdentifier: "MCAApplicationFormVC") as! MCAApplicationFormVC
            navigationController?.pushViewController(applicationFormVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    //MARK: - Action Methods
    
    @IBAction func resumeApplicationTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
        let applicationFormVC = storyBoard.instantiateViewController(withIdentifier: "MCAApplicationFormVC") as! MCAApplicationFormVC
        applicationFormVC.applicationStatus = ApplicationStatus.ResumeApplication.rawValue
        navigationController?.pushViewController(applicationFormVC, animated: true)
    }
    
    @IBAction func copyApplicationTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
        let applicationFormVC = storyBoard.instantiateViewController(withIdentifier: "MCAApplicationFormVC") as! MCAApplicationFormVC
        applicationFormVC.applicationStatus = ApplicationStatus.CopyApplication.rawValue
        navigationController?.pushViewController(applicationFormVC, animated: true)
    }

}
