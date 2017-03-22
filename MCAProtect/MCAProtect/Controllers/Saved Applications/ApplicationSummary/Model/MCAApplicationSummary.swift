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
    var loanValue : String!
    
    var applicationSummary: String!

    var fieldCount : Int!
    
    init(data : NSDictionary?) {
        
        if nil != data {
            
            fieldCount = data?.allKeys.count
        }
        else {
            businessName = "Miami Florists"
            submittedOn = "10 Days ago"
            neededIn = "3 Days"
            loanValue = "$60000"
            fieldCount = 4;
        }
    }
    
    func getValueFromKey(key: ApplicationSummaryKeys) -> String{
        
        switch key {
        case ApplicationSummaryKeys.SASummarySubmittedOn :
            return submittedOn;
            
        case ApplicationSummaryKeys.SASummaryBusinessName :
            return businessName;

        case ApplicationSummaryKeys.SASummaryNeedeIn :
            return neededIn;

        case ApplicationSummaryKeys.SASummaryLoanValue :
            return loanValue;

            default : break
        }
    }
}
