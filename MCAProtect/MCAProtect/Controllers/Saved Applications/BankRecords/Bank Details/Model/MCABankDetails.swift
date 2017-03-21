//
//  MCABankDetails.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABankDetails: NSObject {
    
    var accountNumber : String?
    var range : String?
    var statemenetPeriod : String?
    var numberOfDeposits : Int?
    var depositAmount : Float?
    var daysWithNegativeBalance : Int?
    var averageDailyBalance : Float?

    init(data : NSDictionary?) {
        if nil == data {
            
        }
        else {
            
        }
    }
}
