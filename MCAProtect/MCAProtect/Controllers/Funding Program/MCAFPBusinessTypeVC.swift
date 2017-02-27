//
//  MCAFPBusinessTypeVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 27/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
enum businessType : NSInteger {
    case allowed = 0
    case restricted = 1
    case prohibited = 2

}
class MCAFPBusinessTypeVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var allowedButton : UIButton!
    @IBOutlet weak var restrictedButton : UIButton!
    @IBOutlet weak var prohibitedButton : UIButton!
    @IBOutlet weak var tableView: UITableView!

    
    var allowedDataArray : [String] = ["Program Information","Max Term","Minimum Loan Amount","Maximum Loan Amount","Buy rate","Max Up Sell Rate","Max % of Gross Revenue","Origination Fee","Loan Type","Installment Type","Accept Loan Position","Loan Agreement False"]
    
    var restrictedDataArray :[String] = ["Minimum Credit Score","Minimum Time in Business","Minimum Monthly Sales","Minimum Number of Bank Deposits(Avg)","Days with Negative Balance","Minimum Deposit Amount(Avg)","Minimum Daily Balance(Avg)"]
    
    var prohibitedDataArray :[String] =
        ["Judgements/Liens Allowed","Number of Judgements/Liens Allowed","Max Liens/Judgements Amount","Is Bankruptcy Allowed?", "Can Merchant be in Payment Plan","Allowed Montly Payment", "Has Merchant Satisfied Bankruptcy?","When Discharged from Bankruptcy?"]
    
    var dataSourceArray : [String] = []


    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MCAApplicationFormTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationFormTVCell")
        dataSourceArray = allowedDataArray;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func businessTypeSelected(_ sender:UIButton )
    {
        switch sender.tag {
        case businessType.allowed.rawValue:
            allowedButton.backgroundColor = ColorConstants.red
            allowedButton.setTitleColor(UIColor.white, for: UIControlState.normal)
             prohibitedButton.backgroundColor = UIColor.white
            prohibitedButton.setTitleColor(ColorConstants.red, for: UIControlState.normal)
            restrictedButton.backgroundColor = UIColor.white
            restrictedButton.setTitleColor(ColorConstants.red, for: UIControlState.normal)
            dataSourceArray = allowedDataArray
            tableView .reloadData()
            
        case businessType.restricted.rawValue:
            allowedButton.backgroundColor = UIColor.white
            allowedButton.setTitleColor(ColorConstants.red, for: UIControlState.normal)
            prohibitedButton.backgroundColor = UIColor.white
            prohibitedButton.setTitleColor(ColorConstants.red, for: UIControlState.normal)
            restrictedButton.backgroundColor = ColorConstants.red
            restrictedButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            dataSourceArray = restrictedDataArray
            tableView.reloadData()


        case businessType.prohibited.rawValue:
            
            allowedButton.backgroundColor = UIColor.white
            allowedButton.setTitleColor(ColorConstants.red, for: UIControlState.normal)
            prohibitedButton.backgroundColor = ColorConstants.red
            prohibitedButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            restrictedButton.backgroundColor = UIColor.white
            restrictedButton.setTitleColor(ColorConstants.red, for: UIControlState.normal)
            dataSourceArray = prohibitedDataArray
            tableView.reloadData()

        default:
            break
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationFormTVCell", for: indexPath) as! MCAApplicationFormTVCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        let title = dataSourceArray[indexPath.row]
        cell.titleLabel.text = title
        cell.titleLabel.font = MCAUtilities.getFontWithFontName(inFontName: "Roboto-Medium", size: 14.0)
        cell.selectedView.isHidden = true
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40.0
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
