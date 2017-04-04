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
    var loanAmount : Int!
    var creditScore : Int!
    var loanRequirementTenure : String!
    var loanTerm : Int!
    var fieldCount : Int!
    
    init(data : NSDictionary?) {
        if nil == data {
            businessName = "Stacy's Boutique"
            loanAmount = 75000
            creditScore = 552
            loanRequirementTenure = "5"
            loanTerm = 6
            fieldCount = 5
        }
        else {
            
        }
    }

    
    
    init(loanApplication : MCALoanApplication?)
    {
        businessName = loanApplication?.businessInfo.legalBusinessName
        loanAmount = loanApplication?.programInfo.loanAmount
        creditScore = loanApplication?.programInfo.creditScore
        loanRequirementTenure = loanApplication?.programInfo.loanRequirementTenure
        loanTerm = loanApplication?.programInfo.loanTerm
        fieldCount = 5
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
            modelValue = loanRequirementTenure
            
        case .loanTerm :
            modelValue = "\(loanTerm!) Months"
        }
        return modelValue
    }
}
