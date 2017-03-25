//
//  MCABankDetails.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABankDetails: NSObject {
    
    var accountNumber : String!
    var range : String!
    var statemenetPeriod : String!
    var numberOfDeposits : Int!
    var depositAmount : Float!
    var daysWithNegativeBalance : Int!
    var averageDailyBalance : Float!
    var fieldCount: Int!
    
    init(data : NSDictionary?) {
        if nil == data {
            accountNumber = "BOA546897236"
            range = "1st Nov 2016 31st Dec 2016"
            statemenetPeriod = "1st-Nov-2016_31st-Dec-2016.pdf"
            numberOfDeposits = 20
            depositAmount = 75000
            daysWithNegativeBalance = 0
            averageDailyBalance =  3300
            fieldCount = 7
        }
        else {
            
        }
    }
    
    func getValueFromKey(key: BankDetailKeys) -> String{
        
        var modelValue : String!
        
        switch key {
            case .accountNumber: modelValue = accountNumber
            case .range : modelValue = range
            case .statementPeriod : modelValue = statemenetPeriod
            case .numberOfDeposits : modelValue = "\(numberOfDeposits!)"
            case .depositAmount : modelValue = MCAUtilities.currencyFormatter(inputItem: depositAmount as AnyObject)
            case .daysWithNegativeBalance : modelValue = "\(daysWithNegativeBalance!)"
            case .avgDailyBalance : modelValue = MCAUtilities.currencyFormatter(inputItem: averageDailyBalance as AnyObject)
        }
        return modelValue
    }
}
