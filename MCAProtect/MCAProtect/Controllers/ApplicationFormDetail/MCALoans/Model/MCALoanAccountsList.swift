//
//  MCALoanAccountsList.swift
//  MCAProtect
//
//  Created by Sarath N S on 03/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCALoanAccountsList: NSObject {
    
    var applicationID       : Int!
    var companyName         : String!
    var createdAt           : String!
    var currentBalance      : Float!
    var frequency           : String!
    var fundedAmount        : Float!
    var loanAccountsListID  : Int!
    var loanTerms           : String!
    var paymentAmount       : Float!
    var updatedAt           : String!
    var fieldCount          : Int!
    
    init(loanAccountList: JSON!) {

        applicationID       = loanAccountList["application_id"].intValue
        companyName         = loanAccountList["company_name"].stringValue
        createdAt           = loanAccountList["created_at"].stringValue
        currentBalance      = loanAccountList["current_balance"].floatValue
        frequency           = loanAccountList["frequency"].stringValue
        fundedAmount        = loanAccountList["funded_amount"].floatValue
        loanAccountsListID  = loanAccountList["id"].intValue
        loanTerms           = loanAccountList["loan_terms"].stringValue
        paymentAmount       = loanAccountList["payment_amount"].floatValue
        updatedAt           = loanAccountList["updated_at"].stringValue 
        fieldCount          = 6
    }
    
    func getValueFromKey(key: MCALoanDetailKeys) -> String {
        
        var modelValue : String!
        
        switch key {
            
            case .company           : modelValue =  companyName
            case .fundedAmount      : modelValue = MCAUtilities.currencyFormatter(inputItem: fundedAmount as AnyObject)
            case .currentBalance    : modelValue = MCAUtilities.currencyFormatter(inputItem: currentBalance as AnyObject)
            case .loanTerms         : modelValue = "\(loanTerms!)"
            case .frequency         : modelValue = frequency
            case .amount            : modelValue = MCAUtilities.currencyFormatter(inputItem: paymentAmount as AnyObject)
        }
        return modelValue.validatedString()
    }

}
