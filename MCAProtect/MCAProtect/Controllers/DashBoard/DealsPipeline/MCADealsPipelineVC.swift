//
//  MCADealsPipelineVC.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCADealsPipelineVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var pipeLineTableView: UITableView!

    
    var dataSource : [String] = ["New","Underwriting", "Need More Stips", "Funded", "DNQ", "Lost", "Renewal"]

    weak var parentController: MCADashboardTabbarVC!

    override func viewDidLoad() {
        super.viewDidLoad()

        pipeLineTableView.register(UINib(nibName: "MCADelasPipelineCell", bundle: nil), forCellReuseIdentifier: "MCADelasPipelineCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - Table View Datasource
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let applicationVC  = UIStoryboard(name: "SavedApplication", bundle: nil).instantiateViewController(withIdentifier: "MCAApplicationListVC") as! MCAApplicationListVC
        
        
        parentController.navigationController?.pushViewController(applicationVC, animated: true);
        
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCADelasPipelineCell") as! MCADelasPipelineCell!
        cell?.selectionStyle = .none
        
        cell?.pipelineTitleLabel.text = dataSource[indexPath.row]
        
        return cell!
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
