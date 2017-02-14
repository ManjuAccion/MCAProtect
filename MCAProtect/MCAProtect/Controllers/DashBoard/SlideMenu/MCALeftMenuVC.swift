//
//  MCALeftMenuVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 14/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCALeftMenuVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var profileHeaderView : UIView!

    @IBOutlet weak var sideMenuTableView : UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        sideMenuTableView.reloadData()

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
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "MCATableViewCell") as UITableViewCell?
        
        if nil == cell {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "MCATableViewCell")
        }
        
        cell?.selectionStyle = .none
        

        return cell!
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 233.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return profileHeaderView
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
