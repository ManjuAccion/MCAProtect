//
//  MCABusinessLocationList.swift
//  MCAProtect
//
//  Created by Sarath N S on 03/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCABusinessLocationList: NSObject {
    
    var applicationId           : Int!
    var businessLocationType    : String!
    var city                    : String!
    var createdAt               : String!
    var businessLocationListID  : Int!
    var locationName            : String!
    var minimunMonthlySales     : String!
    var monthlyPayment          : Int!
    var state                   : MCABillingState!
    var streetAddress           : String!
    var zipcode                 : String!
    
    init(businessLocationList: JSON!) {
        
        if businessLocationList.isEmpty {
            return
        }
        applicationId           = businessLocationList["application_id"].intValue
        businessLocationType    = businessLocationList["business_location_type"].stringValue
        city                    = businessLocationList["city"].stringValue
        createdAt               = businessLocationList["created_at"].stringValue
        businessLocationListID  = businessLocationList["id"].intValue
        locationName            = businessLocationList["location_name"].stringValue
        minimunMonthlySales     = businessLocationList["minimun_monthly_sales"].stringValue
        monthlyPayment          = businessLocationList["monthly_payment"].intValue
        let stateJson           = businessLocationList["state"]
        if !stateJson.isEmpty {
            state = MCABillingState(billingState: stateJson)
        }
        streetAddress           = businessLocationList["street_address"].stringValue
        zipcode                 = businessLocationList["zipcode"].stringValue
    }


}
