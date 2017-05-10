//
//  MCALeftMenuVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 14/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import iOS_Slide_Menu

import SwiftyJSON

class MCALeftMenuVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    let loginVC : MCALoginViewController! = nil
    
    @IBOutlet var versionFooterView : UIView!
    @IBOutlet var profileHeaderView : MCAProfileHeaderView!
    @IBOutlet weak var sideMenuTableView : UITableView!

    var arrayDataSource : [String] = ["Dashboard","Merchant Applications", "Saved Applications", "Funding Programs","Ask Funder"]
    var arrayImageIcons : [String] = ["iconDashboard","iconSavedApplications","iconSavedApplications", "iconFundingPrograms", "iconAskFunder"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
               
        

        sideMenuTableView.register(UINib(nibName: "MCATableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MCATableViewCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.updateProfileDetails()
    
    }
    
    func updateProfileDetails(){
        sideMenuTableView.reloadData()
        profileHeaderView.setPrfileDetails(mcapUser: MCASessionManager.sharedSessionManager.mcapUser)
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
            
            case leftMenuItems.MerchantApplications.rawValue:
                let storyboard = UIStoryboard(name: StoryboardName.MCAMerchantApplication, bundle: nil)
                let applicationVC = storyboard.instantiateViewController(withIdentifier: VCIdentifiers.MCAMerchantApplicationListVC) as! MCAMerchantApplicationListVC
                SlideNavigationController.sharedInstance().setViewControllers([SlideNavigationController.sharedInstance().topViewController!,applicationVC], animated: false);
                SlideNavigationController.sharedInstance().toggleLeftMenu()
            
            case leftMenuItems.SavedApplications.rawValue:
                
                let storyboard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: nil)
                let applicationVC = storyboard.instantiateViewController(withIdentifier: VCIdentifiers.MCASavedApplicationListVC) as! MCASavedApplicationListVC
                SlideNavigationController.sharedInstance().setViewControllers([SlideNavigationController.sharedInstance().topViewController!,applicationVC], animated: false);
                SlideNavigationController.sharedInstance().toggleLeftMenu()
            
            case leftMenuItems.FundingPrograms.rawValue:
                
                let fundingProgramStoryBoard = UIStoryboard.init(name:StoryboardName.MCAFundingProgram, bundle: nil)
                let FundingProgramListVC = fundingProgramStoryBoard.instantiateViewController(withIdentifier: "FundingProgramListViewController")
                // Use these below lines to push the views from side menu.
                // Make sure you call the toggleLeftMenu() or toggleRightMenu()
                SlideNavigationController.sharedInstance().setViewControllers([SlideNavigationController.sharedInstance().topViewController!,FundingProgramListVC], animated: false);
                SlideNavigationController.sharedInstance().toggleLeftMenu()
            
            case leftMenuItems.AskFunder.rawValue:
                let askFunderStoryboard = UIStoryboard.init(name:StoryboardName.MCAAskFunder, bundle: nil)
                let askFunderListVC = askFunderStoryboard.instantiateViewController(withIdentifier: VCIdentifiers.MCAAskFunderApplicationListVC)
                SlideNavigationController.sharedInstance().setViewControllers([SlideNavigationController.sharedInstance().topViewController!,askFunderListVC], animated: false);
                SlideNavigationController.sharedInstance().toggleLeftMenu()
            
            default:
                break
            }
    }
    
    @IBAction  func profileButtonClicked()
    {
        
        let profileStoryBoard = UIStoryboard.init(name:"ProfileDetail", bundle: nil)
        let ProfileVC = profileStoryBoard.instantiateViewController(withIdentifier: "MCAProfileViewController")
        SlideNavigationController.sharedInstance().setViewControllers([SlideNavigationController.sharedInstance().topViewController!,ProfileVC], animated: false);
        SlideNavigationController.sharedInstance().toggleLeftMenu()
        
    }
    
    @IBAction func SingoutClicked(_ sender: Any)
    {
        
            if self.checkNetworkConnection() == false {
        return
    }
    
    self.showActivityIndicator()

        let paramDict  = Dictionary<String, String>()
        
        
        MCAWebServiceManager.sharedWebServiceManager.deleteRequest(requestParam:paramDict,
                                                                   endPoint:MCAAPIEndPoints.BrokerLogoutAPIEndPoint
            , successCallBack:{ (response : JSON!) in
                
                self.stopActivityIndicator()
                print("Success \(response)")
                MCASessionManager.sharedSessionManager.mcapUser = MCAUser(loginUserData:response, userLoginType: 0)
                
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let loginVC = storyboard.instantiateViewController(withIdentifier: "MCALoginViewController") as! MCALoginViewController
                
                 let stack = NSArray.init(object: loginVC)
                SlideNavigationController.sharedInstance().viewControllers = stack as! [UIViewController]
                
                SlideNavigationController.sharedInstance().popToRootViewController(animated: true)
                
                
        },
              failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "SignOut Failed", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
        
        
    }
    
    
}

