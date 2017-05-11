//
//  MCABrokersListVC.swift
//  MCAProtect
//
//  Created by Sarath Neeravallil on 10/05/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABrokersListVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,MCACustomSearchBarDelegate {

    
    @IBOutlet weak var searchBar: MCACustomSearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [MCASavedApplication]()
    var displayList = [MCASavedApplication]()
    var filteredDisplayList = [MCASavedApplication]()
    
    //MARK: - View Life Cycle -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Brokers"
        tableView.register(UINib(nibName: "MCABrokersListTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCABrokersListTVCell)
        tableView.tableFooterView = UIView()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"iconPlus"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(addBroker))
        searchBar.delegate = self;
        
        loadBrokers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.configureUI()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addBroker() {
        
    }
    
    func loadBrokers() {
        
    }

    
    //MARK: - Table View DataSource Methods -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCABrokersListTVCell, for: indexPath) as! MCABrokersListTVCell
        cell.selectionStyle = .none

        cell.backgroundColor = ColorConstants.background
        
        return cell

    }
    
    //MARK: - Table View Delegate Methods-

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //MARK : - Custom Search bar delegate
    
    func searchTextDidBegin(inSearchString:String) {
        print("searchTextDidBegin")
    }
    
    func searchTextWillChangeWithString(inSearchString:String) {
        
    }
    
    func searchTextCleared() {
        print("searchTextCleared")
        
    }
    
    func searchTextDidEndWithString(inSearchString:String) {
        print("searchTextDidEndWithString")
    }
    
    


    

}
