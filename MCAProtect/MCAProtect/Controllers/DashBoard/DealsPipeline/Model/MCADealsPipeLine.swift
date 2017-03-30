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
    
    init(dealsPipeLine: JSON!) {
        
        if dealsPipeLine.isEmpty {
            
            applicationStateID = 1
            applicationStateName = "New"
            applicationCount = 5
            sum = 85887.0
            average = 14314.5
            dealsFunded  = 0
            return
        }
        
        applicationCount = dealsPipeLine["application_count"] != JSON.null ? dealsPipeLine["application_count"].intValue : 0
        
        applicationStateID = dealsPipeLine["application_state_id"] != JSON.null ? dealsPipeLine["application_state_id"].intValue : 0
        
        applicationStateName = dealsPipeLine["application_state_name"] != JSON.null ? dealsPipeLine["application_state_name"].stringValue : ""
        
        average = dealsPipeLine["average"] != JSON.null ? dealsPipeLine["average"].floatValue : 0
        
        dealsFunded = dealsPipeLine["deals_funded"] != JSON.null ? dealsPipeLine["deals_funded"].intValue : 0
        
        sum = dealsPipeLine["sum"] != JSON.null ? dealsPipeLine["sum"].floatValue : 0
    }

}
