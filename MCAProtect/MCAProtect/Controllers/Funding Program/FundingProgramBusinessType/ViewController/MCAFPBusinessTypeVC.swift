//
//  MCAFPBusinessTypeVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 27/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

enum businessType : NSInteger {
    case allowed = 0
    case restricted = 1
    case prohibited = 2

}
class MCAFPBusinessTypeVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var segmentControl : UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField : UITextField!
    
    var fundingProgram : MCAFundingProgram!

    
    var allowedDataArray : [String] = ["Program Information","Max Term","Minimum Loan Amount","Maximum Loan Amount","Buy rate","Max Up Sell Rate","Max % of Gross Revenue","Origination Fee","Loan Type","Installment Type","Accept Loan Position","Loan Agreement False"]
    
    var restrictedDataArray :[String] = ["Minimum Credit Score","Minimum Time in Business","Minimum Monthly Sales","Minimum Number of Bank Deposits(Avg)","Days with Negative Balance","Minimum Deposit Amount(Avg)","Minimum Daily Balance(Avg)"]
    
    var prohibitedDataArray :[String] =
        ["Judgements/Liens Allowed","Number of Judgements/Liens Allowed","Max Liens/Judgements Amount","Is Bankruptcy Allowed?", "Can Merchant be in Payment Plan","Allowed Montly Payment", "Has Merchant Satisfied Bankruptcy?","When Discharged from Bankruptcy?"]
    
    var allowedBusinessNames : [JSON]!
    var restrictedBusinessNames : [JSON]!
    var prohibitedBusinessNames : [JSON]!

    
    var dataSourceArray : [JSON]!


    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MCAApplicationFormTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationFormTVCell")
        self.title = "Business Types"
        // Do any additional setup after loading the view.
        
        getFundingProgramById()
    }
    
    
    func  getFundingProgramById()  {
        
        self.showActivityIndicator()
        
        
        var endPoint = MCAAPIEndPoints.BrokerFunderProgramEndpoint
        endPoint.append("\(fundingProgram.funderId!)")
        
        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:[:],
                                                                endPoint:endPoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()
                
                let responseDcit = response.dictionaryValue;
                
                self.allowedBusinessNames = responseDcit["allowed_business_names"]?.array
                print("\(self.allowedBusinessNames)")
                self.restrictedBusinessNames = responseDcit["restricted_business_names"]?.array
                self.prohibitedBusinessNames =  responseDcit["prohibited_business_names"]?.array
                self.dataSourceArray = self.allowedBusinessNames
                self.tableView.reloadData()
        },
              failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Unable to fetch Funding Programs", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func businessTypeSelected(_ sender:UISegmentedControl )
    {
        switch sender.selectedSegmentIndex {
        case businessType.allowed.rawValue:
     
            dataSourceArray = allowedBusinessNames
            tableView .reloadData()
            
        case businessType.restricted.rawValue:
            dataSourceArray = restrictedBusinessNames
            tableView.reloadData()


        case businessType.prohibited.rawValue:
            
        dataSourceArray = prohibitedBusinessNames
            tableView.reloadData()

        default:
            break
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSourceArray != nil
        {
        return dataSourceArray.count
        }
        else{
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationFormTVCell", for: indexPath) as! MCAApplicationFormTVCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        let dict = dataSourceArray[indexPath.row]
        let sicString = dict["sic_code"].stringValue + "  " + dict["type_name"].stringValue
        cell.titleLabel.text = sicString
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
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
