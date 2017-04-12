//
//  MCAFPMerchantRquirement.swift
//  MCAProtect
//
//  Created by Accion Labs on 27/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAFPMerchantRquirement: NSObject {

    
    
    var minimumCreditScore      : String!
    var minimumTimeInBusiness   : String!
    var minimumMonthlySales     : Int!
    var minimumNumOfBankDeposits: String!
    var daysWithNegativeBalance : String!
    var minimumDepositeAmount   : Float!
    var minimumDailyBalance     : Float!
    var fieldCount              : Int!

    init(data : JSON!) {
        
        if data != nil {
            
            minimumCreditScore          = data["min_credit_fico"].stringValue
            minimumTimeInBusiness       = data["min_business_age"].stringValue
            minimumMonthlySales         = data["min_monthly_sales"].intValue
            minimumNumOfBankDeposits    = data["min_bank_deposits_months"].stringValue
            daysWithNegativeBalance     = data["negative_days_accepted"].stringValue
            minimumDepositeAmount       = data["min_avg_deposit"].floatValue
            minimumDailyBalance         = data["min_avg_daily_balance"].floatValue
            
            fieldCount                  = 7
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
                modelValue = MCAUtilities.currencyFormatter(inputItem: minimumDepositeAmount as AnyObject)
                
            case .FPMinimumDailyBalance :
                modelValue = MCAUtilities.currencyFormatter(inputItem: minimumDailyBalance as AnyObject)
            
        }
        return modelValue.validatedString()
    }

}
