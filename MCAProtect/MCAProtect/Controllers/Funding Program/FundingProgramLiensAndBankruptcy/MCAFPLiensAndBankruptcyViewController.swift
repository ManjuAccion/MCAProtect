//
//  MCAFPLiensAndBankruptcyViewController.swift
//  MCAProtect
//
//  Created by Accion Labs on 06/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFPLiensAndBankruptcyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    
    var headerArray : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         tableView.register(UINib(nibName: "MCAApplicationSummaryTVCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCAApplicationSummaryTVCell)
        tableView.register(UINib(nibName: "MCALiensHeaderTableViewCell", bundle: Bundle.main), forCellReuseIdentifier:CellIdentifiers.MCALiensHeaderTableViewCell)

        headerArray = NSMutableArray.init()
        
      

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAApplicationSummaryTVCell, for: indexPath) as! MCAApplicationSummaryTVCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        switch indexPath.section {
        case 0:
            return cell
        case 1:
            return cell

        case 2:
            return cell
        default:
            break
        }
        
        return cell
    
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCALiensHeaderTableViewCell) as! MCALiensHeaderTableViewCell
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return  60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view  = UIView.init(frame: CGRect(x:0, y:0,width: self.view.frame.size.width ,height:5))
        view.backgroundColor = ColorConstants.greyAlpha20
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
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
