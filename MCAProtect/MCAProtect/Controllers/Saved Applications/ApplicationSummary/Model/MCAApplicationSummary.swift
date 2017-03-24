//
//  MCAApplicationSummary.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAApplicationSummary: NSObject {
    
    var businessName : String!
    var submittedOn : String!
    var neededIn : String!
    var loanValue : Float!
    

    var fieldCount : Int!
    
    init(data : NSDictionary?) {
        
        if nil != data {
            
            fieldCount = data?.allKeys.count
        }
        else {
            businessName = "Miami Florists"
            submittedOn = "10 Days ago"
            neededIn = "3 Days"
            loanValue = 600000
            fieldCount = 4;
        }
    }
    
    func getValueFromKey(key: ApplicationSummaryKeys) -> String{
        
        var modelValue : String!
        
        switch key {
            case .SASummarySubmittedOn :
                modelValue =  submittedOn
                
            case .SASummaryBusinessName :
                modelValue = businessName

            case .SASummaryNeedeIn :
                modelValue = neededIn

            case .SASummaryLoanValue :
                modelValue = MCAUtilities.currencyFormatter(inputItem: loanValue as AnyObject)

        }
        return modelValue
    }
}
