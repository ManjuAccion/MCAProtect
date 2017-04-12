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
    
    var applicationStateID      : Int!
    var applicationStateName    : String!
    var applicationCount        : Int!
    var sum                     : Float!
    var average                 : Float!
    var dealsFunded             : Int!
    
    init(dealsPipeLine: JSON) {
        
        applicationCount        = dealsPipeLine["application_count"].intValue
        applicationStateID      = dealsPipeLine["application_state_id"].intValue
        applicationStateName    = dealsPipeLine["application_state_name"].stringValue
        average                 = dealsPipeLine["average"].floatValue
        dealsFunded             = dealsPipeLine["deals_funded"].intValue
        sum                     = dealsPipeLine["sum"].floatValue
    }

}
