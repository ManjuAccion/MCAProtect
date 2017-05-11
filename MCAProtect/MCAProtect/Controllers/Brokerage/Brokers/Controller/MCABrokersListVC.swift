//
//  MCABrokersListVC.swift
//  MCAProtect
//
//  Created by Sarath Neeravallil on 10/05/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABrokersListVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var searchBar: MCACustomSearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Life Cycle -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Brokers"
        
        loadBrokers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadBrokers() {
        
    }

    
    //MARK: - Table View DataSource Methods -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell

    }
    
    //MARK: - Table View Delegate Methods-

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    

}
