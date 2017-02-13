//
//  MCADashboardTabbarVC.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.tabBar.tintColor = UIColor.red
//        self.tabBar.barTintColor = UIColor.green

        // Do any additional setup after loading the view.
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

        
        switch (sender as AnyObject).tag
        {
        case 0:
            if(nil == dealsFundedVC)
            {
                dealsFundedVC = self.storyboard!.instantiateViewController(withIdentifier: "DealsFunded") as! MCADealsFundedVC
            }
            self.tabbarContentView.addSubview(dealsFundedVC.view);
            print("Fisrt Tab selected");
                break
        case 1:
            if(nil == dealsPipelineVC)
            {
                dealsPipelineVC = self.storyboard!.instantiateViewController(withIdentifier: "DealsPipeline") as! MCADealsPipelineVC
            }

            self.tabbarContentView.addSubview(dealsPipelineVC.view);
            print("Second Tab selected");
                break
        case 2:
            if(nil == performanceCompVC)
            {
                performanceCompVC = self.storyboard!.instantiateViewController(withIdentifier: "PerformanceComparison") as! MCAPerformanceComparisonVS
            }
            self.tabbarContentView.addSubview(performanceCompVC.view);
            print("Third Tab selected");
                break
        default:
            
            break
        }
        
    }
    
}
