//
//  MCANavigationController.swift
//  MCAProtect
//
//  Created by Manjunath on 14/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import iOS_Slide_Menu

class MCANavigationController: SlideNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor(red: 168.0/255.0, green: 42.0/255.0, blue: 42.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: MCAUtilities.getFontWithFontName(inFontName: "Roboto-Medium", size: 18.0), NSForegroundColorAttributeName:UIColor.black]
        
        let barAppearance = UIBarButtonItem.appearance()
        barAppearance.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)

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

}
