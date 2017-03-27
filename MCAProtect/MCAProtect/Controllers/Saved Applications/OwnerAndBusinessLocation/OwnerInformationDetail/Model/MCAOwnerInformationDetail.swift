//
//  MCAOwnerInformationDetail.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAOwnerInformationDetail: NSObject {
    
    var name : String!
    var socialSecurityNumber : String!
    var dob : String!
    var streetAddress : String!
    var city : String!
    var state : String!
    var zipCode : String!
    var homePhone : String!
    var percentOwned : String!
    var fieldCount : Int!
    
    init(data: NSDictionary?) {
        
        if nil == data {
            name                    = "Randell D'souza"
            socialSecurityNumber    = "666346173"
            dob                     = "1969-12-12"
            streetAddress           = "4455 W Deming PL"
            city                    = "Alabama"
            state                   = "Illinois"
            zipCode                 = "60639"
            homePhone               = "(801) 459-2206"
            percentOwned            = "50%"
            fieldCount              = 9
        }
        else {
            
        }
    }
    
    func getValueFromKey(ownerInformationKey: OwnerInformationDetailKeys) -> String{
        
        var modelValue : String!
        
        switch ownerInformationKey {
            case .name :
                modelValue =  name
                
            case .socialSecurityNumber :
                modelValue = socialSecurityNumber
                
            case .dob :
                modelValue = dob
                
            case .streetAddress :
                modelValue = streetAddress
                
            case .city :
                modelValue =  city
            
            case .state :
                modelValue = state
            
            case .zipCode :
                modelValue = zipCode
                
            case .homePhone :
                modelValue = homePhone
                
            case .percentOwned :
                modelValue = percentOwned
            
        }
        return modelValue
    }
}
