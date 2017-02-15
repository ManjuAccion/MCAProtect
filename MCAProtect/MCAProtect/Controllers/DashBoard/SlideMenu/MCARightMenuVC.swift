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

         sideRightMenuTableView.register(UINib(nibName: "MCATableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MCATableViewCell")
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCATableViewCell", for: indexPath) as! MCATableViewCell
        
        cell.cellLabel.text  = self.arrayDataSource[indexPath.row]
        cell.cellImageView.image = UIImage(named : self.arrayImageIcons[indexPath.row])
        cell.backgroundColor = UIColor.clear
        return cell
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
