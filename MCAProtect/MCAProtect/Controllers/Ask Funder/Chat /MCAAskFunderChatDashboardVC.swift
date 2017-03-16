//
//  MCAAskFunderChatDashboardVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/15/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

enum chatType : NSInteger {
    case recentChat = 0
    case merchantChat = 1
    case funderChat = 2
    
}

class MCAAskFunderChatDashboardVC: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var composeButton : UIButton!
    var profileImage : UIImage!
    
    
    var recentDataArray : [String] =  ["The Jewellery Shop", "Stacy's Boutique", "Miami Florists", "Food Truck", "Sport's World"]
    
    var merchantDataArray :[String] =  ["The Jewellery Shop", "Stacy's Boutique", "Miami Florists", "Food Truck", "Sport's World"]
    
    var funderDataArray :[String] =   ["The Jewellery Shop", "Stacy's Boutique", "Miami Florists", "Food Truck", "Sport's World"]

    
    var dataSourceArray : [String] = []

    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Communication"
        
        tableView.register(UINib(nibName: "MCAAskFunderCommunicationTVCell", bundle: Bundle.main), forCellReuseIdentifier:"MCAAskFunderCommunicationTVCell")
        self.automaticallyAdjustsScrollViewInsets = false


        
        composeButton.layer.cornerRadius = 0.5 * composeButton.bounds.size.width
        composeButton.clipsToBounds = true
        composeButton.layer.shadowOpacity = 1.0

        composeButton.layer.shadowColor = UIColor.lightGray.cgColor
        composeButton.layer.shadowOffset = CGSize(width:0,height:2.0)
        composeButton.layer.shadowRadius = 5.0
        composeButton.layer.masksToBounds = false
        
        profileImage =  UIImage(named : "malecostume")

        
        dataSourceArray = recentDataArray

    }
    @IBAction func businessTypeSelected(_ sender:UISegmentedControl )
    {
        switch sender.selectedSegmentIndex {
        case chatType.recentChat.rawValue:
            
            dataSourceArray = recentDataArray
            profileImage =  UIImage(named : "malecostume")
            tableView .reloadData()
            
        case chatType.merchantChat.rawValue:
            dataSourceArray = merchantDataArray
            profileImage =  UIImage(named : "b2g")

            tableView.reloadData()
            
            
        case chatType.funderChat.rawValue:
            
            dataSourceArray = funderDataArray
            profileImage =  UIImage(named : "bgLogo")
            tableView.reloadData()
            
        default:
            break
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCAAskFunderCommunicationTVCell", for: indexPath) as! MCAAskFunderCommunicationTVCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        let title = dataSourceArray[indexPath.row]
        cell.nameLabel.text = title
        cell.profileImgeView.image = profileImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
