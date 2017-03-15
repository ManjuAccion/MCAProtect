//
//  MCAAskFunderChatDashboardVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/15/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAAskFunderChatDashboardVC: MCABaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Communication"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
