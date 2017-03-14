//
//  MCAAskFunderApplicationList.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAAskFunderApplicationList: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    var dataDataSource = ["The Jewellery Shop", "Stacy's Boutique", "Miami Florists", "Food Truck", "Sport's World"]
    var amountDataSource = ["$2000","$3000","$4000","$5000","$6000"]
    var selectedIndexpath : IndexPath?

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField : UITextField!
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Ask Funder"
        tableView.register(UINib(nibName: "MCAAskFunderApplicationListTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAAskFunderApplicationListTVCell)
        tableView.tableFooterView = UIView()
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAAskFunderApplicationListTVCell, for: indexPath) as! MCAAskFunderApplicationListTVCell
        
        cell.selectionStyle = .none
        cell.nameLabel.text = dataDataSource[indexPath.row]
        cell.amountLabel.text = amountDataSource[indexPath.row]
        cell.backgroundColor = ColorConstants.background
        
        if let selectedIndexpath = selectedIndexpath, selectedIndexpath == indexPath {
            cell.selectedView.isHidden = false
            cell.backgroundColor = ColorConstants.selectedBackground
        } else {
            cell.selectedView.isHidden = true
        }

        return cell
    }
    
    //MARK: - UITableView Delegate Functions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if selectedIndexpath != nil {
            let deselectedCell = tableView.cellForRow(at: selectedIndexpath! as IndexPath) as? MCAAskFunderApplicationListTVCell
            deselectedCell?.selectedView.isHidden = true
            deselectedCell?.backgroundColor = ColorConstants.background
        }
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCAAskFunderApplicationListTVCell
        selectedCell.selectedView.isHidden = false
        selectedCell.backgroundColor = ColorConstants.selectedBackground
        selectedIndexpath = indexPath
        
        let storyBoard = UIStoryboard(name: StoryboardName.MCAAskFunder, bundle: Bundle.main)
        let askFunderApplicationSummaryVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAAskFunderApplicationSummaryVC) as! MCAAskFunderApplicationSummaryVC
        askFunderApplicationSummaryVC.titleText = dataDataSource[indexPath.row]
        navigationController?.pushViewController(askFunderApplicationSummaryVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    //MARK: UITextFiled Delegate Functions

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
