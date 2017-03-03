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
    case SavedApplications = 1
    case FundingPrograms = 2
    case Communication = 3
}

class MCALeftMenuVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var versionFooterView : UIView!
    @IBOutlet var profileHeaderView : UIView!
    @IBOutlet weak var profileImageButton : UIButton!
    @IBOutlet weak var sideMenuTableView : UITableView!

    var arrayDataSource : [String] = ["Dashboard", "Saved Applications", "Funding Programs","Ask Funder"]
    var arrayImageIcons : [String] = ["iconDashboard","iconSavedApplications", "iconFundingPrograms", "iconAskFunder"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImageButton.layer.borderWidth = 1.0;
        self.profileImageButton.layer.cornerRadius = profileImageButton.frame.height/2
        self.profileImageButton.layer.borderColor = UIColor.white.cgColor
        profileImageButton.clipsToBounds = true
        
        
        sideMenuTableView.register(UINib(nibName: "MCATableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MCATableViewCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        sideMenuTableView.reloadData()
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
        
        switch indexPath.row {
            
            case leftMenuItems.Dashboard.rawValue:
                
                SlideNavigationController.sharedInstance().toggleLeftMenu();
            
            case leftMenuItems.SavedApplications.rawValue:
                
                let storyboard = UIStoryboard(name: "SavedApplication", bundle: nil)
                let applicationVC = storyboard.instantiateViewController(withIdentifier: VCIdentifiers.MCASavedApplicationListVC) as! MCASavedApplicationListVC
                SlideNavigationController.sharedInstance().setViewControllers([SlideNavigationController.sharedInstance().topViewController!,applicationVC], animated: false);
                SlideNavigationController.sharedInstance().toggleLeftMenu()
            
            case leftMenuItems.FundingPrograms.rawValue:
                
                let fundingProgramStoryBoard = UIStoryboard.init(name:"FundingProgram", bundle: nil)
                let FundingProgramListVC = fundingProgramStoryBoard.instantiateViewController(withIdentifier: "FundingProgramListViewController")
                // Use these below lines to push the views from side menu.
                // Make sure you call the toggleLeftMenu() or toggleRightMenu()
                SlideNavigationController.sharedInstance().setViewControllers([SlideNavigationController.sharedInstance().topViewController!,FundingProgramListVC], animated: false);
                SlideNavigationController.sharedInstance().toggleLeftMenu()
            
            case leftMenuItems.Communication.rawValue: break
                
            default:
                print("Default value")
            }
    }
    
    @IBAction  func profileButtonClicked()
    {
        
        let profileStoryBoard = UIStoryboard.init(name:"ProfileDetail", bundle: nil)
        let ProfileVC = profileStoryBoard.instantiateViewController(withIdentifier: "MCAProfileViewController")
        SlideNavigationController.sharedInstance().pushViewController(ProfileVC, animated: false)
        
    }
}
