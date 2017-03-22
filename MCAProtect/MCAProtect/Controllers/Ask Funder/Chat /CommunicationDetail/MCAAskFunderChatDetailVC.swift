//
//  MCAAskFunderChatDetailVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/15/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAAskFunderChatDetailVC: MCABaseViewController {

    
    //MARK: - View Life Cycle 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Miami Florists"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"iconRecentWhite"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.rightBarButtonclicked))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func rightBarButtonclicked() {
        
        let storyBoard = UIStoryboard(name: StoryboardName.MCAAskFunder, bundle: Bundle.main)
        let askFunderDashboardVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAAskFunderChatDashboardVC) as! MCAAskFunderChatDashboardVC
        navigationController?.pushViewController(askFunderDashboardVC, animated: true)
    }

}
