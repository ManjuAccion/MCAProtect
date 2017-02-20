//
//  MCARightMenuVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 14/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import iOS_Slide_Menu

enum rightMenuItems : NSInteger {
    case Notification = 0
    case PersonalisedSettings = 1
    case AboutUs = 2
    case TermsOfUse = 3
    case PrivacyPolicy = 4
    case ShareFeedback = 5
    case ShareApp = 6
    case RateUs = 7
}
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
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if (rightMenuItems.Notification.rawValue == indexPath.row) {
            
        }
        
        if (rightMenuItems.PersonalisedSettings.rawValue == indexPath.row) {
            
        }
        if (rightMenuItems.AboutUs.rawValue == indexPath.row) {
            let storyboard = UIStoryboard(name: "WebView", bundle: nil)
            let applicationVC = storyboard.instantiateViewController(withIdentifier: "WebView") as! MCAWebViewController
            applicationVC.nameTitle = NSLocalizedString("About Us", comment: "")
            // Use these below lines to push the views from side menu.
            // Make sure you call the toggleLeftMenu() or toggleRightMenu()
            SlideNavigationController.sharedInstance().setViewControllers([SlideNavigationController.sharedInstance().topViewController!,applicationVC], animated: false);
            SlideNavigationController.sharedInstance().toggleLeftMenu();

        }
        if (rightMenuItems.TermsOfUse.rawValue == indexPath.row) {
            
            let storyboard = UIStoryboard(name: "WebView", bundle: nil)
            let applicationVC = storyboard.instantiateViewController(withIdentifier: "WebView") as! MCAWebViewController
            applicationVC.nameTitle = NSLocalizedString("Terms Of Use", comment: "")
            // Use these below lines to push the views from side menu.
            // Make sure you call the toggleLeftMenu() or toggleRightMenu()
            SlideNavigationController.sharedInstance().setViewControllers([SlideNavigationController.sharedInstance().topViewController!,applicationVC], animated: false);
            SlideNavigationController.sharedInstance().toggleLeftMenu();
            
        }
        if (rightMenuItems.PrivacyPolicy.rawValue == indexPath.row) {
            
            let storyboard = UIStoryboard(name: "WebView", bundle: nil)
            let applicationVC = storyboard.instantiateViewController(withIdentifier: "WebView") as! MCAWebViewController
            applicationVC.nameTitle = NSLocalizedString("Privacy Policy", comment: "")
            // Use these below lines to push the views from side menu.
            // Make sure you call the toggleLeftMenu() or toggleRightMenu()
            SlideNavigationController.sharedInstance().setViewControllers([SlideNavigationController.sharedInstance().topViewController!,applicationVC], animated: false);
            SlideNavigationController.sharedInstance().toggleLeftMenu();
            
        }
        if (rightMenuItems.ShareFeedback.rawValue == indexPath.row) {
            
        }
        if (rightMenuItems.ShareApp.rawValue == indexPath.row) {
            
        }
        if (rightMenuItems.RateUs.rawValue == indexPath.row) {
            
        }
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
