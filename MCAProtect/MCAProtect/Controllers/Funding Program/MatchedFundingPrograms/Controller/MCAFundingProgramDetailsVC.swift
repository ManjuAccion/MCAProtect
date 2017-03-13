//
//  MCAFundingProgramDetailsVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 09/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFundingProgramDetailsVC: MCABaseViewController {
    @IBOutlet weak var checkButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Green Box Capital"
        checkButton.setImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
        checkButton.isSelected = false;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkButtonTapped (_ : Any)
    {
        if (checkButton.isSelected == true)
        {
            checkButton.setImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
            checkButton.isSelected = false;
        }
        else
        {
            checkButton.setImage(UIImage(named: "icon_checked"), for: UIControlState.normal)
            
            checkButton.isSelected = true;
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
