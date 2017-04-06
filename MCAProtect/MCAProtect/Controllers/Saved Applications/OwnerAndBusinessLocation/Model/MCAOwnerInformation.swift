//
//  MCAOwnerInformation.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAOwnerInformation: NSObject {
    
    var address                 : String!
    var city                    : String!
    var dob                     : String!
    var email                   : String!
    var firstName               : String!
    var homeTelephone           : String!
    var ownerInformationID      : Int!
    var lastName                : String!
    var percentageOwned         : Int!
    var ssnNumber               : String!
    var state                   : MCABillingState!
    var title                   : String!
    var zipcode                 : String!
    var ownerName               : String?
    var socialSecurityNumber    : String?
    var ownerInfoFieldCount     : Int!
    
    
    init(ownerInformation: JSON!) {
        
        if ownerInformation.isEmpty {
            return
        }
        address             = ownerInformation["address1"].stringValue
        city                = ownerInformation["city"].stringValue
        dob                 = ownerInformation["dob"].stringValue
        email               = ownerInformation["email"].stringValue
        firstName           = ownerInformation["first_name"].stringValue
        homeTelephone       = ownerInformation["home_telephone"].stringValue
        ownerInformationID  = ownerInformation["id"].intValue
        lastName            = ownerInformation["last_name"].stringValue
        percentageOwned     = ownerInformation["percentage_owned"].intValue
        ssnNumber           = ownerInformation["ssn_number"].stringValue
        let stateJson       = ownerInformation["state"]
        
        if !stateJson.isEmpty {
            state           = MCABillingState(billingState: stateJson)
        }
        title               = ownerInformation["title"].stringValue
        zipcode             = ownerInformation["zipcode"].stringValue
        ownerName           = firstName + " " + lastName
        ownerInfoFieldCount = 9
    }
    
    func getValueFromKey(ownerInformationKey: OwnerInformationDetailKeys) -> String{
        
        var modelValue : String!
        
        switch ownerInformationKey {
            
        case .name :
            modelValue =  ownerName
            
        case .socialSecurityNumber :
            modelValue = ssnNumber
            
        case .dob :
            modelValue = dob
            
        case .streetAddress :
            modelValue = address
            
        case .city :
            modelValue =  city
            
        case .state :
            modelValue = state.stateName
            
        case .zipCode :
            modelValue = zipcode
            
        case .homePhone :
            modelValue = homeTelephone
            
        case .percentOwned :
            modelValue = "\(percentageOwned!)%"
            
        }
        return modelValue
    }

}
