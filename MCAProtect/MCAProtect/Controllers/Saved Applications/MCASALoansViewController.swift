//
//  MCASALoansViewController.swift
//  MCAProtect
//
//  Created by Accion Labs on 02/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASALoansViewController: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var applicationStatus : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MCA Loans"
        tableView.register(UINib(nibName: "MCASALoansTVCell", bundle: Bundle.main), forCellReuseIdentifier:"MCASALoansTVCell")
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    public func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "MCASALoansTVCell", for: indexPath) as! MCASALoansTVCell
       
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
        let loanDetailsVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCASALoanDetailVC) as! MCASALoanDetailVC
        loanDetailsVC.applicationStatus = applicationStatus
        navigationController?.pushViewController(loanDetailsVC, animated: true)

    }

}
