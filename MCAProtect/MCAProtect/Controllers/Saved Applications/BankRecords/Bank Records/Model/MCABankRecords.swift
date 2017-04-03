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
    
    
    //TODO: - Need to remove the old data
    
    var accountNumber : String!
    var bankRecordsCount : Int!

    init(data : NSDictionary?) {

        if nil == data {
            
            bankName = "Bank Of America"
            accountNumber = "BOA76587650"
            averageDailyBalance = 2200
            bankRecordsCount = 4
            
        }
        else {
            
        }
    }
    
    
    init(bankRecords: JSON!){
        
        if bankRecords.isEmpty{
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
    }
}
