//
//  MCALeftMenuVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 14/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import iOS_Slide_Menu

enum leftMenuItems : NSInteger {
    case Dashboard = 0
    case MerchantApplications = 1
    case SavedApplications = 2
    case FundingPrograms = 3
    case Communication = 4
}

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
        
        
        sideMenuTableView.register(UINib(nibName: "MCATableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MCATableViewCell")
        

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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCATableViewCell", for: indexPath) as! MCATableViewCell
        cell.cellLabel.text  = self.arrayDataSource[indexPath.row]
        cell.cellImageView.image = UIImage(named : self.arrayImageIcons[indexPath.row])
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return profileHeaderView.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return profileHeaderView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row ==  leftMenuItems.Dashboard.rawValue) {
           
            SlideNavigationController.sharedInstance().toggleLeftMenu();

        }
        if (indexPath.row == leftMenuItems.MerchantApplications.rawValue)
        {
            let storyboard = UIStoryboard(name: "Application", bundle: nil)
            let applicationVC = storyboard.instantiateViewController(withIdentifier: "MCAApplicationListVC") as! MCAApplicationListVC
            
            // Use these below lines to push the views from side menu.
            // Make sure you call the toggleLeftMenu() or toggleRightMenu() 
            SlideNavigationController.sharedInstance().setViewControllers([SlideNavigationController.sharedInstance().topViewController!,applicationVC], animated: false);
            SlideNavigationController.sharedInstance().toggleLeftMenu();
            
        }
        if indexPath.row == leftMenuItems.SavedApplications.rawValue {
            
        }
        if (indexPath.row == leftMenuItems.FundingPrograms.rawValue) {
            
            self.navigationController?.viewControllers.remove(at: 0)
            

            let fundingProgramStoryBoard = UIStoryboard.init(name:"FundingProgram", bundle: nil)
            let FundingProgramListVC = fundingProgramStoryBoard.instantiateViewController(withIdentifier: "FundingProgramListViewController")
            SlideNavigationController.sharedInstance().pushViewController(FundingProgramListVC, animated: false)
        }
        if (indexPath.row == leftMenuItems.Communication.rawValue) {
            
        }
    }
    
    
    @IBAction  func profileButtonClicked()
    {

        let profileStoryBoard = UIStoryboard.init(name:"ProfileDetail", bundle: nil)
        let ProfileVC = profileStoryBoard.instantiateViewController(withIdentifier: "MCAProfileViewController")
           SlideNavigationController.sharedInstance().pushViewController(ProfileVC, animated: false)
        
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
