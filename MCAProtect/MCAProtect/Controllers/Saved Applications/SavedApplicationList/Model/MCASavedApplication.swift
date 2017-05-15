//
//  MCASavedApplicationList.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCASavedApplication: NSObject {
    
    var applicationName     : String!
    var amount              : Float!
    var merchantName        : String!
    var merchantEmail       : String!
    var merchantPhoneNumber : String!
    var neededIn            : String!
    var brokerId            : Int!
    var merchantId          : Int!
    var applicationId       : Int!
    var submittedOn         : String!
    var loanTerm            : String!

    var isSelected          : Bool!

    
    init(savedApplcation : JSON!) {
        
        applicationName     = savedApplcation["business_name"].stringValue
        amount              = savedApplcation["loan_amount"].floatValue
        merchantName        = savedApplcation["contact_name"].stringValue
        merchantEmail       = savedApplcation["merchant_mail"].stringValue
        merchantPhoneNumber = savedApplcation["contact_number"].stringValue
        brokerId            = savedApplcation["broker_id"].intValue
        merchantId          = savedApplcation["merchant_id"].intValue
        applicationId       = savedApplcation["id"].intValue
        neededIn            = savedApplcation["loan_requirement_tenure"].stringValue
        submittedOn         = savedApplcation["updated_at"].stringValue
        isSelected          = false
    }
    
    func getValueFromKey(key: ApplicationSummaryKeys) -> String{
        
        var modelValue : String!
        
        switch key {
            case .SASummarySubmittedOn :
                let dateValue = MCAUtilities.getDateFromString(dateString: submittedOn)
                let submittedDuration = MCAUtilities.daysBetweenDate(startDate: dateValue, endDate: NSDate() as Date)
                modelValue = submittedDuration
            
            case .SASummaryBusinessName :
                modelValue = applicationName
                
            case .SASummaryNeedeIn :
                modelValue = "\(neededIn!)"
                
            case .SASummaryLoanValue :
                modelValue = MCAUtilities.currencyFormatter(inputItem: amount as AnyObject)
            
        }
        return modelValue.validatedString()
    }
}
