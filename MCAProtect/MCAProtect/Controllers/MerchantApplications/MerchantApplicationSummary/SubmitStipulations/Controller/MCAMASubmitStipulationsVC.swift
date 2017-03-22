//
//  MCAMASubmitStipulationsVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/9/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMASubmitStipulationsVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: -View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MCASubmitStipulationsCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCASubmitStipulationsCell)
        self.title = "Submit Stipulations"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View DataSource functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCASubmitStipulationsCell) as! MCASubmitStipulationsCell
        
        return cell
    }
    
    //MARK: - Table View Delegate functions
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = Bundle.main.loadNibNamed("MCASubmitStipulationsView", owner: self, options: nil)?[0] as! MCASubmitStipulationsView
        footerView.addMoreDocumentsButton.layer.cornerRadius = 3.0
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60.0
    }

}
