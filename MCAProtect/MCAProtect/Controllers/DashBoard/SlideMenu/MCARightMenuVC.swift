//
//  MCARightMenuVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 14/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCARightMenuVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var sideRightMenuTableView : UITableView!
    
    var arrayDataSource : [String] = ["Notification","Personalised Settings", "About Us", "Terms of Use", "Privacy Policy","Share Feedback","Share App","Rate Us"]
    var arrayImageIcons : [String] = ["iconNotifications","iconMerchantApplications", "iconAboutUs","iconTermsOfUse", "iconFundingPrograms", "iconCommunication","iconNotifications","iconTermsOfUse"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sideRightMenuTableView.reloadData()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "MCARightTableViewCell") as UITableViewCell?
        
        if nil == cell {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "MCARightTableViewCell")
        }
        
        cell?.selectionStyle = .none
        cell?.textLabel?.text  = self.arrayDataSource[indexPath.row]
        cell?.imageView?.image = UIImage(named : self.arrayImageIcons[indexPath.row])
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.textColor = UIColor.white
        cell?.textLabel?.font = UIFont.init(name: "Roboto-Medium", size: 18)
        
        
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
