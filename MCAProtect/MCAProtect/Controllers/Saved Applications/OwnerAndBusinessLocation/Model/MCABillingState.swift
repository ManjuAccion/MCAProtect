//
//  MCABillingState.swift
//  MCAProtect
//
//  Created by Sarath N S on 03/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCABillingState: NSObject {
    
    var countryId       : Int!
    var createdAt       : String!
    var billingStateID  : Int!
    var stateCode       : AnyObject!
    var stateName       : String!
    var updatedAt       : String!
    
    init(billingState: JSON!) {
        
        if billingState.isEmpty{
            return
        }
        countryId = billingState["country_id"].intValue
        createdAt = billingState["created_at"].stringValue
        billingStateID = billingState["id"].intValue
        stateCode = billingState["state_code"].stringValue as AnyObject
        stateName = billingState["state_name"].stringValue
        updatedAt = billingState["updated_at"].stringValue
    }


}
