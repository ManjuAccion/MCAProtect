//
//  MCAAskFunderApplicationListVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAAskFunderApplicationListVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MCAAskFunderApplicationListTVCellDelegate {

    var selectedIndexpath : IndexPath?
    var askFunderApplicationList : MCAAskFunderApplicationList!
    var askFunderDataSource = [MCAAskFunderApplicationList]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField : UITextField!
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Ask Funder"
        
        for _ in 1...5
        {
            askFunderApplicationList = MCAAskFunderApplicationList(data:nil)
            askFunderDataSource.append(askFunderApplicationList)
        }
        
        tableView.register(UINib(nibName: "MCAAskFunderApplicationListTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAAskFunderApplicationListTVCell)
        tableView.tableFooterView = UIView()
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return askFunderDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAAskFunderApplicationListTVCell, for: indexPath) as! MCAAskFunderApplicationListTVCell
        
        cell.selectionStyle = .none
        
        askFunderApplicationList = askFunderDataSource[indexPath.row]
        cell.setAskFunderApplicationList(applicationList: askFunderApplicationList)

        cell.backgroundColor = ColorConstants.background
        cell.delegate = self
        
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
        askFunderApplicationList = askFunderDataSource[indexPath.row]
        askFunderApplicationSummaryVC.titleText = askFunderApplicationList.name
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
    
    //MARK: - MCAAskFunderApplicationListTVCellDelegate Functions
    
    func chatButtonTapped() {
        let storyBoard = UIStoryboard(name: StoryboardName.MCAAskFunder, bundle: Bundle.main)
        let askFunderChatDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAAskFunderChatDetailVC) as! MCAAskFunderChatDetailVC
        navigationController?.pushViewController(askFunderChatDetailVC, animated: true)
    }

}
