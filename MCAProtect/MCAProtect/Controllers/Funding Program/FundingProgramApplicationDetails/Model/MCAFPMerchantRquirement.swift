//
//  MCAFPMerchantRquirement.swift
//  MCAProtect
//
//  Created by Accion Labs on 27/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFPMerchantRquirement: NSObject {

    
    
    var minimumCreditScore : String!
    var minimumTimeInBusiness : String!
    var minimumMonthlySales : Int!
    var minimumNumOfBankDeposits : String!
    var daysWithNegativeBalance : String!
    var minimumDepositeAmount : String!
    var minimumDailyBalance : String!
    var fieldCount : Int!

    
    
    init(data : NSDictionary?) {
        
        if data != nil {
            
        }
        else
        {
            minimumCreditScore = "Syndicate Premium"
            minimumTimeInBusiness = "10 Months"
            minimumMonthlySales = 5000
            minimumNumOfBankDeposits = "4 per 6 Months"
            daysWithNegativeBalance = "5 per 6 Months"
            minimumDepositeAmount = "$5000 per 6 Months"
            minimumDailyBalance = "$1000 per 6 Months"
            fieldCount = 7
        }
    }
    
    func getValueFromKey(key: FPMerchantRequirementkeys) -> String{
        
        var modelValue : String!
        
        switch key {
        case .FPMinimumCreditScore :
            modelValue =  minimumCreditScore
            
        case .FPMinimumTimeInBusiness :
            modelValue = minimumTimeInBusiness
            
        case .FPMinimumMonthlySales :
            modelValue = MCAUtilities.currencyFormatter(inputItem: minimumMonthlySales as AnyObject)
            
        case .FPMinimumNumOfBankDeposits :
            modelValue = minimumNumOfBankDeposits
            
            
        case .FPDaysWithNegativeBalance :
            modelValue = daysWithNegativeBalance
            
        case .FPMinimumDepositeAmount :
            modelValue = minimumDepositeAmount
            
        case .FPMinimumDailyBalance :
            modelValue = minimumDailyBalance
            
        }
        return modelValue
    }

}
