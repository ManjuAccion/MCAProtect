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

    
    
    var minimumCreditScore : String!
    var minimumTimeInBusiness : String!
    var minimumMonthlySales : Int!
    var minimumNumOfBankDeposits : String!
    var daysWithNegativeBalance : String!
    var minimumDepositeAmount : Float!
    var minimumDailyBalance : Float!
    var fieldCount : Int!

    
    
    init(Data : JSON!) {
        
        if Data != nil {
            minimumCreditScore = Data["min_credit_fico"] != JSON.null ? Data["min_credit_fico"].stringValue : ""
            minimumTimeInBusiness = Data["min_business_age"] != JSON.null ? Data["min_business_age"].stringValue : ""
            minimumMonthlySales = Data["min_monthly_sales"] != JSON.null ? Data["min_monthly_sales"].intValue : 0
            minimumNumOfBankDeposits = Data["min_bank_deposits_months"] != JSON.null ? Data["min_bank_deposits_months"].stringValue : ""
            daysWithNegativeBalance = Data["negative_days_accepted"] != JSON.null ? Data["negative_days_accepted"].stringValue : ""
            minimumDepositeAmount = Data["min_avg_deposit"] != JSON.null ? Data["min_avg_deposit"].floatValue : 0.0
            minimumDailyBalance = Data["min_avg_daily_balance"] != JSON.null ? Data["min_avg_daily_balance"].floatValue : 0.0
            
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
            modelValue = MCAUtilities.currencyFormatter(inputItem: minimumDepositeAmount as AnyObject)
            
        case .FPMinimumDailyBalance :
            modelValue = MCAUtilities.currencyFormatter(inputItem: minimumDailyBalance as AnyObject)
            
        }
        return modelValue
    }

}
