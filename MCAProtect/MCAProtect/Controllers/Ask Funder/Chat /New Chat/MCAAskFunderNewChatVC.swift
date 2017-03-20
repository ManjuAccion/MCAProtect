//
//  MCAAskFunderNewChatVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/20/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAAskFunderNewChatVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var dataDataSource = ["The Jewellery Shop", "Stacy's Boutique", "Miami Florists", "Food Truck", "Sport's World"]
    var selectedIndexpath : IndexPath?


    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New Chat"
        tableView.register(UINib(nibName: "MCANewChatTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCANewChatTVCell)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCANewChatTVCell, for: indexPath) as! MCANewChatTVCell
        cell.selectionStyle = .none

        cell.nameLabel.text = dataDataSource[indexPath.row]
        
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
            let deselectedCell = tableView.cellForRow(at: selectedIndexpath! as IndexPath) as? MCANewChatTVCell
            deselectedCell?.selectedView.isHidden = true
            deselectedCell?.backgroundColor = ColorConstants.background
        }
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCANewChatTVCell
        selectedCell.selectedView.isHidden = false
        selectedCell.backgroundColor = ColorConstants.selectedBackground
        selectedIndexpath = indexPath
        
        let storyBoard = UIStoryboard(name: StoryboardName.MCAAskFunder, bundle: Bundle.main)
        let askFunderChatDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAAskFunderChatDetailVC) as! MCAAskFunderChatDetailVC
        navigationController?.pushViewController(askFunderChatDetailVC, animated: true)
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
