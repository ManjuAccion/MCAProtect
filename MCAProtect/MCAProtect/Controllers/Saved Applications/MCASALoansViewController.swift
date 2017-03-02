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


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MCA Loans"
        tableView.register(UINib(nibName: "MCASALoansTVCell", bundle: Bundle.main), forCellReuseIdentifier:"MCASALoansTVCell")
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
