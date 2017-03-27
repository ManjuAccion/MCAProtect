//
//  MCABusinessLocationDetail.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABusinessLocationDetail: NSObject {
    
    var locationType : String!
    var monthlyPayment : Float!
    var streetAddress : String!
    var city : String!
    var state : String!
    var zipCode : String!
    var fieldCount: Int!
    

    
    init(data: NSDictionary?) {
        
        if nil == data {
            locationType    = "Mortgaged"
            monthlyPayment  = 1200
            streetAddress   = "E 12 Deming PL"
            city            = "Star City"
            state           = "Alabama"
            zipCode         = "12345"
            fieldCount      = 6
        }
        else {
            
        }
    }
    
    func getValueFromKey(businessLocationKey: BusinessLocationDetailKeys) -> String{
        
        var modelValue : String!
        
        switch businessLocationKey {
            case .locationType :
                modelValue =  locationType
                
            case .monthlyPayement :
                modelValue = MCAUtilities.currencyFormatter(inputItem: monthlyPayment as AnyObject)
                
            case .streetAddress :
                modelValue = streetAddress
                
            case .city :
                modelValue = city
                
            case .state :
                modelValue = state
                
            case .zipCode :
                modelValue = zipCode
        }
        return modelValue
    }
    
}
