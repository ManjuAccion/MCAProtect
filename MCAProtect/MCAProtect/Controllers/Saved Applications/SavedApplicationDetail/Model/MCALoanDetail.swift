//
//  MCALoanDetail.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/20/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCALoanDetail: NSObject {
    
    var businessName : String!
    var loanAmount : Float!
    var creditScore : Int!
    var loanRequirementTenure : Int!
    var loanTerm : Int!
    var fieldCount : Int!
    
    init(data : NSDictionary?) {
        if nil == data {
            businessName = "Stacy's Boutique"
            loanAmount = 75000
            creditScore = 552
            loanRequirementTenure = 5
            loanTerm = 6
            fieldCount = 5
        }
        else {
            
        }
    }
    
    func getValueFromKey(key:LoanDetailKeys) -> String {
        
        var modelValue : String!
        
        switch key {
        case .businessName :
            modelValue =  businessName
            
        case .loanAmount :
            modelValue = MCAUtilities.currencyFormatter(inputItem: loanAmount as AnyObject)
            
        case .creditScore :
            modelValue = "\(creditScore!)"
            
        case .needItBy :
            modelValue = "\(loanRequirementTenure!)"
            
        case .loanTerm :
            modelValue = "\(loanTerm!)"
        }
        return modelValue
    }
}
