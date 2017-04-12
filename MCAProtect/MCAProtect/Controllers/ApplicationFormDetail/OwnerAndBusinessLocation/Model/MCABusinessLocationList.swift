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
    var fieldCount              : Int!
    
    init(businessLocationList: JSON!) {
        
        if businessLocationList.isEmpty {
            return
        }
        applicationId           = businessLocationList["application_id"] != JSON.null ? businessLocationList["application_id"].intValue : 0
        businessLocationType    = businessLocationList["business_location_type"] != JSON.null ? businessLocationList["business_location_type"].stringValue : ""
        city                    = businessLocationList["city"] != JSON.null ? businessLocationList["city"].stringValue : ""
        createdAt               = businessLocationList["created_at"] != JSON.null ? businessLocationList["created_at"].stringValue : ""
        businessLocationListID  = businessLocationList["id"] != JSON.null ? businessLocationList["id"].intValue : 0
        locationName            = businessLocationList["business_location_type"] != JSON.null ? businessLocationList["business_location_type"].stringValue : ""
        minimunMonthlySales     = businessLocationList["minimun_monthly_sales"] != JSON.null ? businessLocationList["minimun_monthly_sales"].stringValue : ""
        monthlyPayment          = businessLocationList["monthly_payment"] != JSON.null ? businessLocationList["monthly_payment"].intValue : 0
        let stateJson           = businessLocationList["state"] != JSON.null ? businessLocationList["state"] : ""
        
        if !stateJson.isEmpty {
            state = MCABillingState(billingState: stateJson)
        }
        streetAddress           = businessLocationList["street_address"] != JSON.null ? businessLocationList["street_address"].stringValue : ""
        zipcode                 = businessLocationList["zipcode"] != JSON.null ? businessLocationList["zipcode"].stringValue : ""
        fieldCount              = 6
    }
    
    func getValueFromKey(businessLocationKey: BusinessLocationDetailKeys) -> String {
        
        var modelValue : String!
        
        switch businessLocationKey {
            
            case .locationType      : modelValue =  businessLocationType
            case .monthlyPayement   : modelValue = MCAUtilities.currencyFormatter(inputItem: monthlyPayment as AnyObject)
            case .streetAddress     : modelValue = streetAddress
            case .city              : modelValue = city
            case .state             : modelValue = state.stateName
            case .zipCode           : modelValue = zipcode
        }
        return modelValue.validatedString()
    }
}
