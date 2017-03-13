//
//  MCAGenericPopViewController.swift
//  MCAProtect
//
//  Created by Accion Labs on 13/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAGenericPopViewController: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    var commonRateDataSource : [String] = ["01", "02", "03","04","05","06","07","08","09","10"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MCAPopUpTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MCAPopUpTableViewCell")


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commonRateDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAPopUpTableViewCell", for: indexPath) as! MCAPopUpTableViewCell
        cell.titleLabel.text  = self.commonRateDataSource[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }


    @IBAction func closeButtonTapped()
    {
      self .dismiss(animated: true, completion: nil)
        
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
