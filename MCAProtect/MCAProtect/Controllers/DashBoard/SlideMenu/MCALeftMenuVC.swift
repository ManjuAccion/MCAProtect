//
//  MCALeftMenuVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 14/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCALeftMenuVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var versionFooterView : UIView!

    @IBOutlet var profileHeaderView : UIView!
    @IBOutlet weak var profileImageButton : UIButton!

    @IBOutlet weak var sideMenuTableView : UITableView!

    var arrayDataSource : [String] = ["Dashboard","Merchant Applications", "Saved Applications", "Funding programs", "Communication"]
    var arrayImageIcons : [String] = ["iconDashboard","iconMerchantApplications", "iconSavedApplications", "iconFundingPrograms", "iconCommunication"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImageButton.layer.borderWidth = 1.0;
        self.profileImageButton.layer.cornerRadius = profileImageButton.frame.height/2
        self.profileImageButton.layer.borderColor = UIColor.white.cgColor
        profileImageButton.clipsToBounds = true

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
    
    override func viewDidLayoutSubviews() {
        if (versionFooterView != nil) {
            
            self.sideMenuTableView.tableFooterView = nil;
            let screenSize: CGRect = UIScreen.main.bounds
            let frame = CGRect(x: 0, y: screenSize.height-120, width: 401, height: 120)
            versionFooterView.frame = frame
            self.sideMenuTableView.tableFooterView?.addSubview(versionFooterView)
        


        }
    }
    
    //MARK: - Table View Datasource
    
    
    public func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "MCATableViewCell") as UITableViewCell?
        
        if nil == cell {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "MCATableViewCell")
        }
        
        cell?.selectionStyle = .none
        cell?.textLabel?.text  = self.arrayDataSource[indexPath.row]
        cell?.imageView?.image = UIImage(named : self.arrayImageIcons[indexPath.row])
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.textColor = UIColor.white
        cell?.textLabel?.font = UIFont.init(name: "Roboto-Regular", size: 18)
        

        return cell!
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 215.0
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
