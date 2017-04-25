//
//  MCAFPAdditionalStipulationVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 06/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFPAdditionalStipulationVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
     var dataSourceArray : [String] = ["POI","POA","Bank Statements"]
    var parentDelegate: MCAFPApplicationFormVC!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Additional Stipulations"
        tableView.register(UINib(nibName: "MCAApplicationFormTVCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAApplicationFormTVCell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAApplicationFormTVCell", for: indexPath) as! MCAApplicationFormTVCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        let title = dataSourceArray[indexPath.row]
        cell.titleLabel.text = title
        cell.titleLabel.font = MCAUtilities.getFontWithFontName(inFontName: "Roboto-Medium", size: 18.0)
        cell.selectedView.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    @IBAction func nextButton()
    {
       
        
        parentDelegate.goToNext()
    }
    
    @IBAction func previousButton()
    {
        
        parentDelegate.goToPrevious()
        
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
