//
//  MCAExistingLoanDetail.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAExistingLoanDetail: NSObject {
    
    var funderName : String!
    var fundedAmount : Float!
    var currentBalance : Float!
    var loanTerm : Int!
    var frequency : String!
    var amount : Float!
    var fieldCount : Int!
    
    init(data: NSDictionary?) {
        
        if nil == data {
            funderName      = "Glink Lender"
            fundedAmount    = 20000
            currentBalance  = 5000
            loanTerm        = 4
            frequency       = "Monthly"
            amount          = 1300
            fieldCount      = 6
        }
        else {
            
        }
    }
    
    func getValueFromKey(key: MCALoanDetailKeys) -> String {
        
        var modelValue : String!
        
        switch key {
            
            case .company : modelValue =  funderName
            case .fundedAmount : modelValue = MCAUtilities.currencyFormatter(inputItem: fundedAmount as AnyObject)
            case .currentBalance : modelValue = MCAUtilities.currencyFormatter(inputItem: currentBalance as AnyObject)
            case .loanTerms : modelValue = "\(loanTerm!)"
            case .frequency : modelValue = frequency
            case .amount : modelValue = MCAUtilities.currencyFormatter(inputItem: amount as AnyObject)
        }
        return modelValue
    }
}
