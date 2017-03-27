//
//  MCABankRecords.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABankRecords: NSObject {
    
    var bankName : String!
    var accountNumber : String!
    var averageDailyBalance : Float!
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
}
