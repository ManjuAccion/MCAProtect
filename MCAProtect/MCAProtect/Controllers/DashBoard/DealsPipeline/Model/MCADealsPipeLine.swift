//
//  MCADealsPipeLine.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/29/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCADealsPipeLine: NSObject {
    
    var applicationStateID : Int!
    var applicationStateName : String!
    var applicationCount : Int!
    var sum : Float!
    var average : Float!
    var dealsFunded : Int!
    
    init(dealsPipeLine: Dictionary<String,AnyObject>) {
        
        if dealsPipeLine.isEmpty {
            
            applicationStateID = 1
            applicationStateName = "New"
            applicationCount = 5
            sum = 85887.0
            average = 14314.5
            dealsFunded  = 0
            return
        }
        
        applicationCount = dealsPipeLine["application_count"] as! Int!
        
        applicationStateID = dealsPipeLine["application_state_id"] as! Int!
        
        applicationStateName = dealsPipeLine["application_state_name"] as! String!
        
        average = dealsPipeLine["average"] as! Float!
        
        dealsFunded = dealsPipeLine["deals_funded"] as! Int!
        
        sum = dealsPipeLine["sum"] as! Float!
    }

}
