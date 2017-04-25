//
//  MCAFPBusinessTypeVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 27/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON


class MCAFPBusinessTypeVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,MCACustomSearchBarDelegate {
    
    @IBOutlet weak var segmentControl : UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var seacrhBar : MCACustomSearchBar!
    
    
    var parentDelegate: MCAFPApplicationFormVC!
    var noDataLabel             : UILabel!
    var fundingProgram          : MCAFundingProgram!
    var allowedBusinessNames    : [JSON] = []
    var restrictedBusinessNames : [JSON] = []
    var prohibitedBusinessNames : [JSON] = []
    var filteredList            : [JSON] = []
    var displayList             : [JSON] = []
    var dataSourceArray         : [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MCABusinessTypeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MCABusinessTypeTableViewCell")
        self.title = "Business Types"
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        noDataLabel = MCAUtilities.emptyDataLabel(rect: tableView.frame)
        self.tableView.backgroundView = noDataLabel
        self.tableView.separatorStyle = .none
        
        seacrhBar.delegate = self
        seacrhBar.configureUI()
        getFundingProgramById()
    }
    
    func  getFundingProgramById()  {
        
        if self.checkNetworkConnection() == false {
            return
        }
        
        self.showActivityIndicator()
        
        
        var endPoint = MCAAPIEndPoints.BrokerFunderProgramEndpoint
        endPoint.append("\(fundingProgram.funderId!)")
        
        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:[:],
                                                                endPoint:endPoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()
                
                let responseDcit = response.dictionaryValue;
                
                self.allowedBusinessNames = (responseDcit["allowed_business_names"]?.array)!
                self.restrictedBusinessNames = (responseDcit["restricted_business_names"]?.array)!
                self.prohibitedBusinessNames =  (responseDcit["prohibited_business_names"]?.array)!
                self.dataSourceArray = self.allowedBusinessNames
                self.filterListWithSearchString(searchString: self.seacrhBar.searchTextField.text!)
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
    }
    
    @IBAction func businessTypeSelected(_ sender:UISegmentedControl )
    {
        switch sender.selectedSegmentIndex {
            case businessType.allowed.rawValue:
         
                dataSourceArray = allowedBusinessNames
                self.filterListWithSearchString(searchString: self.seacrhBar.searchTextField.text!)
                
            case businessType.restricted.rawValue:
                dataSourceArray = restrictedBusinessNames
                self.filterListWithSearchString(searchString: self.seacrhBar.searchTextField.text!)


            case businessType.prohibited.rawValue:
                
            dataSourceArray = prohibitedBusinessNames
            self.filterListWithSearchString(searchString: self.seacrhBar.searchTextField.text!)

            default:
                break
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  displayList.count != 0 {
            noDataLabel.isHidden = true
            return displayList.count
        }
        else {
            noDataLabel.isHidden = false
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCABusinessTypeTableViewCell", for: indexPath) as! MCABusinessTypeTableViewCell
        cell.selectionStyle = .none
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = ColorConstants.background
        } else {
            cell.contentView.backgroundColor = ColorConstants.blueAlpha20
        }
        let dict = displayList[indexPath.row]
        let sicString = dict["sic_code"].stringValue
        cell.sicLabel.text = sicString
        cell.typeNameLabel.text = dict["type_name"].stringValue

        cell.sicLabel.font = MCAUtilities.getFontWithFontName(inFontName: "Roboto-Medium", size: 14.0)
        cell.typeNameLabel.font = MCAUtilities.getFontWithFontName(inFontName: "Roboto-Medium", size: 14.0)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK : - Custom Search bar delegate
    
    func searchTextDidBegin(inSearchString:String)
    {
    }
    func searchTextWillChangeWithString(inSearchString:String)
    {
        filterListWithSearchString(searchString: inSearchString)
    }
    
    func searchTextCleared()
    {
        filterListWithSearchString(searchString: "")
        
    }
    func searchTextDidEndWithString(inSearchString:String)
    {
        filterListWithSearchString(searchString: inSearchString)
    }
    
    
    func filterListWithSearchString(searchString: String)
    {
        if searchString != ""
        {
            filteredList.removeAll()
            
            for dict in dataSourceArray {
                
                let stringToSearch = dict["type_name"].stringValue
                
                if stringToSearch == "" || ((stringToSearch.localizedCaseInsensitiveContains(searchString)) == true) {
                    self.filteredList.append(dict)
                }
            }
            
            displayList = filteredList;
        }
        else {
            
            displayList = dataSourceArray;
        }
        
        tableView.reloadData();
    }
    
    @IBAction func nextButton()
    {
        
        
        parentDelegate.goToNext()
    }
    
    @IBAction func previousButton()
    {
        
        parentDelegate.goToPrevious()
        
    }

}
