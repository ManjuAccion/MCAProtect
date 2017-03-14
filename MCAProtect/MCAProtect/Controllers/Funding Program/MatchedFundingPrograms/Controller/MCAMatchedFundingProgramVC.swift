//
//  MCAMatchedFundingProgramVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 08/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMatchedFundingProgramVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource,MatchedFundingProgramCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedCountLabel : UILabel!
    var dataDataSource = ["The Jewellery Shop", "Stacy's Boutique", "Miami Florists", "Food Truck", "Sport's World"]
    var arrayOfModelObject : NSMutableArray?
    
    var matchedFundingProgram : MCAMatchedFundingProgram!
    var selectedItemsCount = 0;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Funding Programs"
        tableView.register(UINib(nibName: "MCAMatchedFPListTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAMatchedFPListTVCell")
        tableView.tableFooterView = UIView()
        arrayOfModelObject  = NSMutableArray.init()
        
        for _   in dataDataSource
        {
            matchedFundingProgram = MCAMatchedFundingProgram(data:nil)
            arrayOfModelObject? .add(matchedFundingProgram)
        }
        
        tableView.reloadData()
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.calculateFundingProgramSelectionCount()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return dataDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
            let listTVCell = tableView.dequeueReusableCell(withIdentifier: "MCAMatchedFPListTVCell", for: indexPath) as! MCAMatchedFPListTVCell
        listTVCell .updateDataSource(matchedFundingProgramObject: arrayOfModelObject?.object(at: indexPath.row) as! MCAMatchedFundingProgram)
        listTVCell.delegate = self
        listTVCell.checkButton.tag = indexPath.row
        listTVCell.selectionStyle = .none
        listTVCell.backgroundColor = UIColor.clear
        return listTVCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: StoryboardName.MCAMatchedFundingProgram, bundle: Bundle.main)
        let matchedFundingProgramDetailVC = storyBoard.instantiateViewController(withIdentifier: "MCAFundingProgramDetailsVC") as! MCAFundingProgramDetailsVC
        matchedFundingProgramDetailVC.matchedFundingProgram = arrayOfModelObject?.object(at: indexPath.row) as! MCAMatchedFundingProgram
        navigationController?.pushViewController(matchedFundingProgramDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {

        return 60
    }
    
    @IBAction func infoButtonTapped(_ sender: Any){
        
        let TitleString = NSAttributedString(string:"Matched Funding Program with Merchant Application", attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Regular", size: 18.0), NSForegroundColorAttributeName : UIColor.black])
        let MessageString = NSAttributedString(string: "Based on the details provided by the merchant you can prepare a list of funding programs.Click the checkbox to select one or multiple funding programs for the merchant.After selecting the desired funding programs,click the Refer to Merchant button at the bottom of the screen.", attributes: [NSFontAttributeName : MCAUtilities.getFontWithFontName(inFontName: "Roboto-Light", size: 12.0), NSForegroundColorAttributeName : UIColor.gray])
        
        let alertViewController = UIAlertController(title : "", message : "", preferredStyle : .alert)
        alertViewController.setValue(TitleString, forKey: "attributedTitle")
        alertViewController.setValue(MessageString, forKey: "attributedMessage")
        alertViewController.view.tintColor = ColorConstants.red
        

        
        alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
        present(alertViewController, animated: true , completion: nil)

    }
    
    func programSelected(buttonTag : Int)
    {
        let selectedProgram : MCAMatchedFundingProgram = arrayOfModelObject! .object(at: buttonTag) as! MCAMatchedFundingProgram
        selectedProgram.isSelected = true
        selectedItemsCount = selectedItemsCount + 1
        selectedCountLabel.text = "\(selectedItemsCount)"

        
    }
    
    func programDeSelected(buttonTag : Int)
    {
        let deselectedProgram : MCAMatchedFundingProgram = arrayOfModelObject! .object(at: buttonTag) as! MCAMatchedFundingProgram
        deselectedProgram.isSelected = false
        selectedItemsCount = selectedItemsCount - 1
        selectedCountLabel.text = "\(selectedItemsCount)"

        
    }
    
    @IBAction func setCommonRateTapped()
    {
        
        let storyBoard = UIStoryboard(name: StoryboardName.MCAGenericPopUp, bundle: Bundle.main)
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: "MCAGenericPopViewController") as! MCAGenericPopViewController
        navigationController?.present(popUpVC, animated: true, completion: nil)
        
    }
    
    
    func calculateFundingProgramSelectionCount()
    {
        
        selectedItemsCount = 0

        for matchedFundingProgram  in arrayOfModelObject!
        {
            if ((matchedFundingProgram as! MCAMatchedFundingProgram).isSelected == true)
            {
                
                selectedItemsCount = selectedItemsCount + 1
            }
        }
        selectedCountLabel.text = "\(selectedItemsCount)"
        tableView.reloadData()
    }
    
    
    
    @IBAction func clearButtonTapped()
    {
        for matchedFundingProgram  in arrayOfModelObject!
        {
           (matchedFundingProgram as! MCAMatchedFundingProgram).isSelected = false
        }
        selectedItemsCount = 0
        selectedCountLabel.text = "0"
        tableView.reloadData()
        
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
