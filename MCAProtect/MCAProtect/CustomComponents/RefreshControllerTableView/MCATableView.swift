//
//  MCATableView.swift
//  MCAProtect
//
//  Created by Manjunath on 17/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit


protocol MCARefreshDelegate {
    func refreshContents()
}


class MCATableView: UITableView {
    var pageCount : Int!
    var endOfPage : Bool!

    var refreshDelegate:MCARefreshDelegate?

    var refreshController : UIRefreshControl!

    
    func addRefreshController()
    {
        refreshController = UIRefreshControl()
        self.addSubview(refreshController)
        refreshController.addTarget(self, action:  #selector(self.refreshTable), for: .valueChanged)
        
    }
    
    
    func refreshTable()
    {
        refreshController.endRefreshing()
        refreshDelegate?.refreshContents()
        print("Refresh Table called")
    }

}
