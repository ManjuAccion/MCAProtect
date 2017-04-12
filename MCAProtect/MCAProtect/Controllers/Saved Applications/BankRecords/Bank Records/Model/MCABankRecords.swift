//
//  MCABankRecords.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCABankRecords: NSObject {
    
    var applicationID               : Int!
    var averageDailyBalance         : Int!
    var bankName                    : String!
    var createdAt                   : String!
    var daysWithNegativeBalance     : Int!
    var bankRecordID                : Int!
    var month                       : AnyObject!
    var monthsAgo                   : AnyObject!
    var numberOfBusinessBankDeposits: Int!
    var pdfUrl                      : String!
    var rangeFromDate               : String!
    var rangeToDate                 : String!
    var totalBankDepositsAmount     : Int!
    var updatedAt                   : String!
    var accountNumber               : String!
    var bankRecordsCount            : Int!
    var bankRecordDetailFieldCount  : Int!
    
    init(bankRecords: JSON!) {
        
        if bankRecords.isEmpty {
            return
        }
        
        applicationID                   = bankRecords["application_id"].intValue
        averageDailyBalance             = bankRecords["average_daily_balance"].intValue
        bankName                        = bankRecords["bank_name"].stringValue
        createdAt                       = bankRecords["created_at"].stringValue
        daysWithNegativeBalance         = bankRecords["days_with_negative_balance"].intValue
        bankRecordID                    = bankRecords["id"].intValue
        month                           = bankRecords["month"].stringValue as AnyObject
        monthsAgo                       = bankRecords["months_ago"].stringValue as AnyObject
        numberOfBusinessBankDeposits    = bankRecords["number_of_business_bank_deposits"].intValue
        pdfUrl                          = bankRecords["pdf_url"].stringValue
        rangeFromDate                   = bankRecords["range_from_date"].stringValue
        rangeToDate                     = bankRecords["range_to_date"].stringValue
        totalBankDepositsAmount         = bankRecords["total_bank_deposits_amount"].intValue
        updatedAt                       = bankRecords["updated_at"].stringValue
        accountNumber                   = "NA" //TODO:- Need to fetch the account number need to add validation also
        bankRecordDetailFieldCount      = 7
    }
    
    func getValueFromKey(key: BankDetailKeys) -> String {
        
        var modelValue : String!
        
        switch key {
            
            case .accountNumber             : modelValue = accountNumber
            case .range                     : modelValue = rangeFromDate + rangeToDate
            case .statementPeriod           : modelValue = rangeFromDate + rangeToDate //TODO:- No seperate value coming for statement period so used range.
            case .numberOfDeposits          : modelValue = "\(numberOfBusinessBankDeposits!)"
            case .depositAmount             : modelValue = MCAUtilities.currencyFormatter(inputItem: totalBankDepositsAmount as AnyObject)
            case .daysWithNegativeBalance   : modelValue = "\(daysWithNegativeBalance!)"
            case .avgDailyBalance           : modelValue = MCAUtilities.currencyFormatter(inputItem: averageDailyBalance as AnyObject)
        }
        return modelValue.validatedString()
    }
}
