//
//  MCAMASummary.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/28/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit


class MCAMASummary: NSObject {
    
    var businessName : String!
    var contactName : String!
    var loanAmount : Float!
    var email : String!
    var telephone : String!
    var offeredOn : String!
    var fieldCount : Int!
    
    init (data: NSDictionary?) {
        if nil == data {
            
            businessName = "Miami Florists"
            contactName = "Christian A"
            loanAmount = 75000
            email = "chirstian.a@gmail.com"
            telephone = "(123) 876 -876"
            offeredOn = "2017-01-21"
            fieldCount = 6
        }
        else {
            
        }
    }

    func getValueFromKey(merchantSummaryKey: MASummaryKeys) -> String{
        
        var modelValue : String!
        
        switch merchantSummaryKey {
            case .businessName :
                modelValue =  businessName
                
            case .contactName :
                modelValue = contactName
                
            case .loanAmount :
                modelValue = MCAUtilities.currencyFormatter(inputItem: loanAmount as AnyObject)
                
            case .email :
                modelValue = email
                
            case .telephone :
                modelValue = telephone
                
            case .offeredOn :
                modelValue = offeredOn
        }
        return modelValue
    }

}
