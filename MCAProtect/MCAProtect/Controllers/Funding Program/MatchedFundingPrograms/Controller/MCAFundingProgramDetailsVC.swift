//
//  MCAFundingProgramDetailsVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 09/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFundingProgramDetailsVC: MCABaseViewController,GenericPopUpDelegate {
    @IBOutlet weak var checkButton : UIButton!
    weak var matchedFundingProgram : MCAMatchedFundingProgram!
    @IBOutlet weak var  funderNameLbl : UILabel!
    @IBOutlet weak var  funderDescriptionLbl : UILabel!
    @IBOutlet weak var  termLbl :  UILabel!
    @IBOutlet weak var  loanRangeLbl : UILabel!
    @IBOutlet weak  var  buyRateLbl : UILabel!
    @IBOutlet weak var  maxUpsellRateLbl : UILabel!
    @IBOutlet weak var  upsellRate : UIButton!
    @IBOutlet weak var  totalRateLbl : UILabel!
    @IBOutlet weak var  headerLbl : UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(matchedFundingProgram.funderName!)"
        self.headerLbl.text = "\(matchedFundingProgram.funderName!)"
        funderNameLbl.text = "\(matchedFundingProgram.funderName!) >"
        funderDescriptionLbl.text = "\(matchedFundingProgram.funderName!) Investments"
        termLbl.text = matchedFundingProgram.term! as String
        loanRangeLbl.text = matchedFundingProgram.loanRange! as String
        buyRateLbl.text = matchedFundingProgram.buyRate! as String
        maxUpsellRateLbl.text = matchedFundingProgram.maxUpsellRate! as String
        totalRateLbl.text = matchedFundingProgram.totalRate! as String
        
        
        if (self.matchedFundingProgram.isSelected == true)
        {
            
            checkButton.setImage(UIImage(named: "icon_checked"), for: UIControlState.normal)

        }
        else
        {
            checkButton.setImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkButtonTapped (_ : Any)
    {
        if (matchedFundingProgram.isSelected == true)
        {
            checkButton.setImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
            matchedFundingProgram.isSelected = false;
        }
        else
        {
            checkButton.setImage(UIImage(named: "icon_checked"), for: UIControlState.normal)
            
            matchedFundingProgram.isSelected = true;
        }
        
    }
    
    @IBAction func setUpSellRateTapped()
    {
        
        let storyBoard = UIStoryboard(name: StoryboardName.MCAGenericPopUp, bundle: Bundle.main)
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: "MCAGenericPopViewController") as! MCAGenericPopViewController
        popUpVC.popUpDelegate = self
        navigationController?.present(popUpVC, animated: true, completion: nil)
        
    }
    
    
    func didItemSelected(object:AnyObject)
    {
        
        upsellRate .setTitle(object as? String, for: UIControlState.normal)
        
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
