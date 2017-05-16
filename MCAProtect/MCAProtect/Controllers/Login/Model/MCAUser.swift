//
//  MCAUser.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/27/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAUser: NSObject {

    var brokerID            : Int!
    var brokarageFirmID     : Int!
    var brokerUID           : String!
    var brokerEmail         : String!
    var brokerContactNumber : String!
    var brokerContactName   : String!
    var brokerImageUrl      : String!
    var userType            : Int!
    var userNotificationCount : Int!

    init(loginUserData: JSON! , userLoginType: Int)
    {
        
        let userData        = loginUserData["data"]
        
        brokerID            = userData["id"].intValue
        brokarageFirmID     = userData["brokerage_firm_id"].intValue
        brokerUID           = userData["uid"].stringValue
        brokerEmail         = userData["email"].stringValue
        brokerContactNumber = userData["contact_number"].stringValue
        brokerContactName   = userData["contact_name"].stringValue
        brokerImageUrl      =  userData["image_url"].stringValue
        userType            = userLoginType
        userNotificationCount = loginUserData["count"].intValue
    }
}
