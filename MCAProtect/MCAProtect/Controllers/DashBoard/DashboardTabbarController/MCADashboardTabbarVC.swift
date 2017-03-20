//
//  MCADashboardTabbarVC.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import iOS_Slide_Menu

enum TabSelected : NSInteger {
    case firstTab = 0
    case secondTab = 1
    case thirdTab = 2
}


class MCADashboardTabbarVC: MCABaseViewController{

    
    
    var dealsPipelineVC : MCADealsPipelineVC!
    var dealsFundedVC : MCADealsFundedVC!
    var performanceCompVC : MCAPerformanceComparisonVS!
    
    @IBOutlet weak var tabbarContentView: UIView!

    @IBOutlet weak var firstTabBtn: UIButton!
    @IBOutlet weak var thirdTabBtn: UIButton!
    @IBOutlet weak var secondTabBtn: UIButton!
    
    
    let selectedTab = TabSelected.firstTab

    @IBOutlet weak var dealsPipelineLabel: UILabel!
    @IBOutlet weak var dealsFundedLAbel: UILabel!
    @IBOutlet weak var performanceComparisonLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Tabbar navigation should be hidden by default!
        self.title = "DashBoard"
        self.navigationController?.setNavigationBarHidden(false, animated: false);
        
        self .setupNavigationBarButtons();
        self.selectTab(firstTabBtn)

        firstTabBtn.backgroundColor = ColorConstants.red

    }
    
    
    func setupNavigationBarButtons()
    {
        SlideNavigationController.sharedInstance().menuRevealAnimationOption = UIViewAnimationOptions.curveEaseOut

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"burgerNav"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.leftBarButtonclicked))
        
  
         self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"optionNav"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.rightBarButtonclicked))
        
          }
    
    func leftBarButtonclicked()
    {
        SlideNavigationController.sharedInstance().toggleLeftMenu();
    }
    
    func rightBarButtonclicked()
    {
        SlideNavigationController.sharedInstance().toggleRightMenu();
    }

    
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: - Tab Selection method

    // Custom Tab bar selection method
    // Responsible for exchanging the View controllers of respective tabs
    // Responsible for changing the Tab UI (Selection and Deselection)
    
    @IBAction func selectTab(_ sender: Any) {
        
        if(nil != dealsFundedVC)
        {
            dealsFundedVC.view.removeFromSuperview();
        }

        if(nil != performanceCompVC)
        {
            performanceCompVC.view.removeFromSuperview();
        }

        if(nil != dealsPipelineVC)
        {
            dealsPipelineVC.view.removeFromSuperview();
        }

        firstTabBtn.backgroundColor = ColorConstants.grey
        secondTabBtn.backgroundColor = ColorConstants.grey
        thirdTabBtn.backgroundColor = ColorConstants.grey
        
        dealsPipelineLabel.textColor = UIColor(colorLiteralRed: 256.0, green: 256.0, blue: 256.0, alpha: 0.85)
        dealsFundedLAbel.textColor =  UIColor(colorLiteralRed: 256.0, green: 256.0, blue: 256.0, alpha: 0.85)
        performanceComparisonLabel.textColor =  UIColor(colorLiteralRed: 256.0, green: 256.0, blue: 256.0, alpha: 0.85)

        
        
        // TODO: need to identify how to use enumerations properly instead of using the constants in Case statement
        switch (sender as AnyObject).tag
        {
        case 0:
            if(nil == dealsPipelineVC)
            {
                dealsPipelineVC = self.storyboard!.instantiateViewController(withIdentifier: "DealsPipeline") as! MCADealsPipelineVC
                dealsPipelineVC.parentController = self
                

                
            }
            dealsPipelineLabel.textColor = UIColor.white

            firstTabBtn.backgroundColor = ColorConstants.red
            self.tabbarContentView.addSubview(dealsPipelineVC.view);
            self.autoresizeViewForController(dealsPipelineVC);
            print("Second Tab selected");
                break
        case 1:
            if(nil == performanceCompVC)
            {
                performanceCompVC = self.storyboard!.instantiateViewController(withIdentifier: "PerformanceComparison") as! MCAPerformanceComparisonVS
            }
            self.tabbarContentView.addSubview(performanceCompVC.view);
            self.autoresizeViewForController(performanceCompVC);
            secondTabBtn.backgroundColor = ColorConstants.red
            performanceComparisonLabel.textColor = UIColor.white

            print("Third Tab selected");
                break
        case 2:
            if(nil == dealsFundedVC)
            {
                dealsFundedVC = self.storyboard!.instantiateViewController(withIdentifier: "DealsFunded") as! MCADealsFundedVC
            }
            self.tabbarContentView.addSubview(dealsFundedVC.view);
            self.autoresizeViewForController(dealsFundedVC);
            thirdTabBtn.backgroundColor = ColorConstants.red
            dealsFundedLAbel.textColor = UIColor.white
            print("Fisrt Tab selected");
            break
        default:
            
            break
        }
        
    }
    
    func autoresizeViewForController(_ aViewController : MCABaseViewController)
    {
            aViewController.view.frame = self.tabbarContentView.bounds;
    }
    
}
