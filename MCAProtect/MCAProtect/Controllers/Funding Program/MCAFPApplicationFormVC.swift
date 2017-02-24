//
//  MCAFPApplicationFormVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 20/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFPApplicationFormVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var dataDataSource = ["Program Information", "Mearchant Requirements", "Liens/Payments/Bankruptcy", "Additional Stipulations", "SIC Code & Business Types"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "MCAApplicationFormTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationFormTVCell")
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationFormTVCell", for: indexPath) as! MCAApplicationFormTVCell
        cell.titleLabel.text = dataDataSource[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
        let applicationDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPApplicationDetailVC") as! MCAFPApplicationDetailVC
        applicationDetailVC.categorySelected = indexPath.row
        navigationController?.pushViewController(applicationDetailVC, animated: true)

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
