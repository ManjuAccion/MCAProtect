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
        
        self.navigationController?.delegate = self
      
        UINavigationBar.appearance().barTintColor = ColorConstants.red
        UINavigationBar.appearance().tintColor =  UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: MCAUtilities.getFontWithFontName(inFontName: "Roboto-Medium", size: 18.0), NSForegroundColorAttributeName:UIColor.white]
    // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    override func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }

   
}
