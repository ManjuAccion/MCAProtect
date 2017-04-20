//
//  MCAFPApplicationFormVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 20/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit




class MCAFPApplicationFormVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
     var selectedIndexPath: IndexPath!
    
    var formDataSource = ["Program Information", "Merchant Requirements", "Liens/Bankruptcy", "Additional Stipulations", "SIC Code & Business Types"]

    var fundingProgram : MCAFundingProgram!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = fundingProgram.fundingProgramName

        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "MCAApplicationFormTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationFormTVCell")
        tableView.tableFooterView = UIView()
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationFormTVCell", for: indexPath) as! MCAApplicationFormTVCell
        cell.titleLabel.text = formDataSource[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath;
        
        if (indexPath.row == 4)
        {
            let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
            let applicationDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPBusinessTypeVC") as! MCAFPBusinessTypeVC
            applicationDetailVC.fundingProgram = fundingProgram
            applicationDetailVC.parentDelegate = self
            navigationController?.pushViewController(applicationDetailVC, animated: true)
            
        }
         else if(indexPath.row == 3)
            {
                let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
                let applicationDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPAdditionalStipulationVC") as! MCAFPAdditionalStipulationVC
                applicationDetailVC.parentDelegate = self
                navigationController?.pushViewController(applicationDetailVC, animated: true)
                
            }
            
        else if(indexPath.row == 2)
        {
            let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
            let applicationDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPLiensAndBankruptcyViewController") as! MCAFPLiensAndBankruptcyViewController
            applicationDetailVC.fundingProgram = fundingProgram
            applicationDetailVC.parentDelegate = self
            navigationController?.pushViewController(applicationDetailVC, animated: true)
            
        }

        else
        {
        let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
        let applicationDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPApplicationDetailVC") as! MCAFPApplicationDetailVC
        applicationDetailVC.categorySelected = indexPath.row
            applicationDetailVC.fundingProgram = fundingProgram
            applicationDetailVC.parentDelegate = self
        navigationController?.pushViewController(applicationDetailVC, animated: true)
        }
        
        let selectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCAApplicationFormTVCell
        selectedCell.selectedView.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedCell = tableView.cellForRow(at: indexPath as IndexPath) as! MCAApplicationFormTVCell
        deselectedCell.selectedView.isHidden = true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func goToNext()
    {

        let indexPath = selectedIndexPath as IndexPath
        
        if(indexPath.row == formDataSource.count - 1) {
            return
        }
        
        
        selectedIndexPath.row = selectedIndexPath.row + 1
        
        if (indexPath.row + 1 == 4)
        {
            let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
            let applicationDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPBusinessTypeVC") as! MCAFPBusinessTypeVC
            applicationDetailVC.parentDelegate = self
            applicationDetailVC.fundingProgram = fundingProgram
            
                var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
                navStackArray.remove(at: navStackArray.count - 1)
                navStackArray.append(applicationDetailVC)
                self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
            
        }
        else if(indexPath.row + 1 == 3)
        {
            let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
            let applicationDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPAdditionalStipulationVC") as! MCAFPAdditionalStipulationVC
            applicationDetailVC.parentDelegate = self
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(applicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        }
            
        else if(indexPath.row + 1 == 2)
        {
            let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
            let applicationDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPLiensAndBankruptcyViewController") as! MCAFPLiensAndBankruptcyViewController
            applicationDetailVC.fundingProgram = fundingProgram
            applicationDetailVC.parentDelegate = self
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(applicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        }
            
        else
        {
            let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
            let applicationDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPApplicationDetailVC") as! MCAFPApplicationDetailVC
            applicationDetailVC.categorySelected = indexPath.row + 1
            applicationDetailVC.fundingProgram = fundingProgram
            applicationDetailVC.parentDelegate = self
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(applicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
        }
        
    }
    func goToPrevious(){
        
        let indexPath = selectedIndexPath as IndexPath
        
        if(indexPath.row == 0) {
            return
        }

        
        selectedIndexPath.row = selectedIndexPath.row - 1

        if (indexPath.row - 1 == 4)
        {
            let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
            let applicationDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPBusinessTypeVC") as! MCAFPBusinessTypeVC
            applicationDetailVC.fundingProgram = fundingProgram
            applicationDetailVC.parentDelegate = self
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(applicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        }
        else if(indexPath.row - 1 == 3)
        {
            let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
            let applicationDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPAdditionalStipulationVC") as! MCAFPAdditionalStipulationVC
            applicationDetailVC.parentDelegate = self
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(applicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        }
            
        else if(indexPath.row - 1 == 2)
        {
            let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
            let applicationDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPLiensAndBankruptcyViewController") as! MCAFPLiensAndBankruptcyViewController
            applicationDetailVC.fundingProgram = fundingProgram
            applicationDetailVC.parentDelegate = self
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(applicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
            
        }
            
        else
        {
            let storyBoard = UIStoryboard(name: "FundingProgram", bundle: Bundle.main)
            let applicationDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFPApplicationDetailVC") as! MCAFPApplicationDetailVC
            applicationDetailVC.categorySelected = indexPath.row - 1
            applicationDetailVC.fundingProgram = fundingProgram
            applicationDetailVC.parentDelegate = self
            var navStackArray : [AnyObject]! = self.navigationController!.viewControllers
            navStackArray.remove(at: navStackArray.count - 1)
            navStackArray.append(applicationDetailVC)
            self.navigationController!.setViewControllers(navStackArray as! [MCABaseViewController], animated:false)
        }
        
    }

    
}
