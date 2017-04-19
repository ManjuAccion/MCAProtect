
//
//  MCAApplicationFormVC
//  MCAProtect
//
//  Created by Sarath NS on 2/15/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAApplicationFormVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    var savedApplication    : MCASavedApplication!
    var loanApplication     : MCALoanApplication!
    
    var selectedIndexpath   : IndexPath!
    var applicationStatus   : Int?
    var applicationId       : Int!
    var titleText           : String!
    
    var dataDataSource = ["Loan Details","Business Information", "Business Address", "Liens/Bankruptcy", "Merchant Documentation", "Bank Records","MCA Loans","Owner/Officer Information","Business Location"]
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = titleText
        tableViewBottomConstraint.constant = 0
        submitButton.layer.cornerRadius = 3.0
        cancelButton.layer.cornerRadius = 3.0
        
        loadUI()
        self.getLoanApplication()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func getLoanApplication(){
        
            if self.checkNetworkConnection() == false {
        return
    }
    
    self.showActivityIndicator()

        
        var endPoint = String()
        endPoint.append(MCAAPIEndPoints.BrokerLoanApplicationAPIEndpoint);
        endPoint.append("/\(applicationId!).json");
        
        
        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:[:],
                                                                endPoint:endPoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()
                print("Success \(response)")
                
                
              self.loanApplication =  MCALoanApplication(loanApplication: response)
                
                
                
                
        },
              failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Dashboard update Failed", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
        
        
    }
    
    func loadUI() {
        
        tableView.register(UINib(nibName: "MCAApplicationStatusTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAApplicationStatusTVCell)
        tableView.register(UINib(nibName: "MCAApplicationFormTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAApplicationFormTVCell)
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.tableFooterView = UIView()
        if applicationStatus == ApplicationStatus.CopyApplication.rawValue || applicationStatus == ApplicationStatus.ResumeApplication.rawValue{
            tableViewBottomConstraint.constant = 60
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        presentAlertWithTitle(title: "", message: NSLocalizedString("Merchant application has been created successfully", comment: ""))
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController!.popViewController(animated: true)
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell :UITableViewCell!
        
        if indexPath.row == 0 {
            let statusTVCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationStatusTVCell, for: indexPath) as! MCAApplicationStatusTVCell
            statusTVCell.statusLabel.text = "Progress"
            cell = statusTVCell

        }
        else {
            let applicationFormCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationFormTVCell, for: indexPath) as! MCAApplicationFormTVCell
            applicationFormCell.titleLabel.text = dataDataSource[indexPath.row - 1]
            if let selectedIndexpath = selectedIndexpath, selectedIndexpath == indexPath{
                applicationFormCell.selectedView.isHidden = false
                applicationFormCell.backgroundColor = ColorConstants.selectedBackground
            }else{
                applicationFormCell.selectedView.isHidden = true
            }
            cell = applicationFormCell
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {

//            if selectedIndexpath != nil {
//                let deselectedCell = tableView.cellForRow(at: selectedIndexpath! as IndexPath) as? MCAApplicationFormTVCell
//                deselectedCell?.selectedView.isHidden = true
//                deselectedCell?.backgroundColor = ColorConstants.background
//                
//            }
//            let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCAApplicationFormTVCell
//            selectedCell.selectedView.isHidden = false
//            selectedCell.backgroundColor = ColorConstants.selectedBackground
            
            selectedIndexpath = indexPath

            switch indexPath.row {
                case SavedApplicationForm.LoanDetails.rawValue:
                    let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
                    let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCABusinessDetailVC) as! MCABusinessDetailVC
                    savedApplicationDetailVC.selectedLoanApp = loanApplication
                    savedApplicationDetailVC.applicationStatus = applicationStatus
                    savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.LoanDetails.rawValue
                    savedApplicationDetailVC.parentDelegate = self;
                    
                    navigationController?.pushViewController(savedApplicationDetailVC, animated: true)
                case SavedApplicationForm.BusinessInformation.rawValue:
                    let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
                    let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCABusinessDetailVC) as! MCABusinessDetailVC
                    savedApplicationDetailVC.selectedLoanApp = loanApplication
                    savedApplicationDetailVC.applicationStatus = applicationStatus
                    savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.BusinessInformation.rawValue
                    savedApplicationDetailVC.parentDelegate = self;

                    navigationController?.pushViewController(savedApplicationDetailVC, animated: true)
                case SavedApplicationForm.BusinessAddress.rawValue:
                    let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
                    let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCABusinessDetailVC) as! MCABusinessDetailVC
                    savedApplicationDetailVC.selectedLoanApp = loanApplication
                    savedApplicationDetailVC.applicationStatus = applicationStatus
                    savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.BusinessAddress.rawValue
                    savedApplicationDetailVC.parentDelegate = self;
                    navigationController?.pushViewController(savedApplicationDetailVC, animated: true)
                case SavedApplicationForm.LiensOrPaymentsOrBankruptcy.rawValue:
                    let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
                    let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier:VCIdentifiers.MCALiensPaymentsVC) as! MCALiensPaymentsVC
                    savedApplicationDetailVC.loanApplication = loanApplication
                    savedApplicationDetailVC.parentDelegate = self;
                    navigationController?.pushViewController(savedApplicationDetailVC, animated: true)

                case SavedApplicationForm.MerchantDocumentation.rawValue:
                    let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
                    let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAMerchantDocumentationVC) as! MCAMerchantDocumentationVC
                    savedApplicationDetailVC.loanApplication = loanApplication
                    savedApplicationDetailVC.parentDelegate = self;
                    navigationController?.pushViewController(savedApplicationDetailVC, animated: true)
                    
                case SavedApplicationForm.BankRecords.rawValue:
                    let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
                    let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCABankRecordsVC) as! MCABankRecordsVC
                    savedApplicationDetailVC.applicationStatus = applicationStatus
                    savedApplicationDetailVC.loanApplication = loanApplication
                    savedApplicationDetailVC.parentDelegate = self;
                    navigationController?.pushViewController(savedApplicationDetailVC, animated: true)
                case SavedApplicationForm.MCALoans.rawValue:
                    let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
                    let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier:VCIdentifiers.MCALoansVC) as! MCALoansVC
                    savedApplicationDetailVC.applicationStatus = applicationStatus
                    savedApplicationDetailVC.loanApplication = loanApplication
                    savedApplicationDetailVC.parentDelegate = self;
                    navigationController?.pushViewController(savedApplicationDetailVC, animated: true)

                case SavedApplicationForm.OwnerOrOfficerInformation.rawValue:
                    let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
                    let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAOwnerAndLocationDetailsVC) as! MCAOwnerAndLocationDetailsVC
                    savedApplicationDetailVC.loanApplication = loanApplication
                    savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.OwnerOrOfficerInformation.rawValue
                    savedApplicationDetailVC.applicationStatus = applicationStatus
                    savedApplicationDetailVC.parentDelegate = self;
                    navigationController?.pushViewController(savedApplicationDetailVC, animated: true)

                case SavedApplicationForm.BusinessLocation.rawValue:
                    let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
                    let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAOwnerAndLocationDetailsVC) as! MCAOwnerAndLocationDetailsVC
                    savedApplicationDetailVC.loanApplication = loanApplication
                    savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.BusinessLocation.rawValue
                    savedApplicationDetailVC.applicationStatus = applicationStatus
                    savedApplicationDetailVC.parentDelegate = self;
                    navigationController?.pushViewController(savedApplicationDetailVC, animated: true)

                default:
                    break

            }
        }
    }
    
    func loadSavedApplicationDetailVC() {

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }


    func goToNext(){
        
        let indexPath = selectedIndexpath! as IndexPath
        
        if(indexPath.row == dataDataSource.count) {
            return
        }
        
        selectedIndexpath.row = selectedIndexpath.row + 1

        switch indexPath.row + 1 {
        case SavedApplicationForm.LoanDetails.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCABusinessDetailVC) as! MCABusinessDetailVC
            savedApplicationDetailVC.selectedLoanApp = loanApplication
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.LoanDetails.rawValue
            savedApplicationDetailVC.parentDelegate = self;
            
            
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        case SavedApplicationForm.BusinessInformation.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCABusinessDetailVC) as! MCABusinessDetailVC
            savedApplicationDetailVC.selectedLoanApp = loanApplication
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.BusinessInformation.rawValue
            savedApplicationDetailVC.parentDelegate = self;
            
            
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        case SavedApplicationForm.BusinessAddress.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCABusinessDetailVC) as! MCABusinessDetailVC
            savedApplicationDetailVC.selectedLoanApp = loanApplication
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.BusinessAddress.rawValue
            savedApplicationDetailVC.parentDelegate = self;
            
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        case SavedApplicationForm.LiensOrPaymentsOrBankruptcy.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier:VCIdentifiers.MCALiensPaymentsVC) as! MCALiensPaymentsVC
            savedApplicationDetailVC.loanApplication = loanApplication
            savedApplicationDetailVC.parentDelegate = self;
            
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        case SavedApplicationForm.MerchantDocumentation.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAMerchantDocumentationVC) as! MCAMerchantDocumentationVC
            savedApplicationDetailVC.loanApplication = loanApplication
            savedApplicationDetailVC.parentDelegate = self;
            
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        case SavedApplicationForm.BankRecords.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCABankRecordsVC) as! MCABankRecordsVC
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.loanApplication = loanApplication
            savedApplicationDetailVC.parentDelegate = self;
            
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        case SavedApplicationForm.MCALoans.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier:VCIdentifiers.MCALoansVC) as! MCALoansVC
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.loanApplication = loanApplication
            savedApplicationDetailVC.parentDelegate = self;
            
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        case SavedApplicationForm.OwnerOrOfficerInformation.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAOwnerAndLocationDetailsVC) as! MCAOwnerAndLocationDetailsVC
            savedApplicationDetailVC.loanApplication = loanApplication
            savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.OwnerOrOfficerInformation.rawValue
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.parentDelegate = self;
            
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        case SavedApplicationForm.BusinessLocation.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAOwnerAndLocationDetailsVC) as! MCAOwnerAndLocationDetailsVC
            savedApplicationDetailVC.loanApplication = loanApplication
            savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.BusinessLocation.rawValue
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.parentDelegate = self;
            
            
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        default:
            break
            
        }
    }
    
    func goToPrevious(){
        

        let indexPath = selectedIndexpath! as IndexPath
        
        if(indexPath.row == 1) {
            return
        }
        
        selectedIndexpath.row = selectedIndexpath.row-1
        
        switch indexPath.row-1 {
        case SavedApplicationForm.LoanDetails.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCABusinessDetailVC) as! MCABusinessDetailVC
            savedApplicationDetailVC.selectedLoanApp = loanApplication
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.LoanDetails.rawValue
            savedApplicationDetailVC.parentDelegate = self;
            

            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)

        case SavedApplicationForm.BusinessInformation.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCABusinessDetailVC) as! MCABusinessDetailVC
            savedApplicationDetailVC.selectedLoanApp = loanApplication
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.BusinessInformation.rawValue
            savedApplicationDetailVC.parentDelegate = self;
            

            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)

        case SavedApplicationForm.BusinessAddress.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCABusinessDetailVC) as! MCABusinessDetailVC
            savedApplicationDetailVC.selectedLoanApp = loanApplication
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.BusinessAddress.rawValue
            savedApplicationDetailVC.parentDelegate = self;

            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)

        case SavedApplicationForm.LiensOrPaymentsOrBankruptcy.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier:VCIdentifiers.MCALiensPaymentsVC) as! MCALiensPaymentsVC
            savedApplicationDetailVC.loanApplication = loanApplication
            savedApplicationDetailVC.parentDelegate = self;

            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)

        case SavedApplicationForm.MerchantDocumentation.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAMerchantDocumentationVC) as! MCAMerchantDocumentationVC
            savedApplicationDetailVC.loanApplication = loanApplication
            savedApplicationDetailVC.parentDelegate = self;

            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)

        case SavedApplicationForm.BankRecords.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCABankRecordsVC) as! MCABankRecordsVC
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.loanApplication = loanApplication
            savedApplicationDetailVC.parentDelegate = self;
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        case SavedApplicationForm.MCALoans.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier:VCIdentifiers.MCALoansVC) as! MCALoansVC
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.loanApplication = loanApplication
            savedApplicationDetailVC.parentDelegate = self;

            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)

        case SavedApplicationForm.OwnerOrOfficerInformation.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAOwnerAndLocationDetailsVC) as! MCAOwnerAndLocationDetailsVC
            savedApplicationDetailVC.loanApplication = loanApplication
            savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.OwnerOrOfficerInformation.rawValue
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.parentDelegate = self;

            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)

        case SavedApplicationForm.BusinessLocation.rawValue:
            let storyBoard = UIStoryboard(name: StoryboardName.MCASavedApplication, bundle: Bundle.main)
            let savedApplicationDetailVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAOwnerAndLocationDetailsVC) as! MCAOwnerAndLocationDetailsVC
            savedApplicationDetailVC.loanApplication = loanApplication
            savedApplicationDetailVC.applicaionDetailType = SavedApplicationForm.BusinessLocation.rawValue
            savedApplicationDetailVC.applicationStatus = applicationStatus
            savedApplicationDetailVC.parentDelegate = self;
            
            
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(savedApplicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        default:
            break
            
        }
    }
    

    
}
