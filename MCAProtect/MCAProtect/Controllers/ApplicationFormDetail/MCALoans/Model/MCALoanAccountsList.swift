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
        
        if loanAccountList.isEmpty {
            return
        }
        applicationID       = loanAccountList["application_id"] != JSON.null ? loanAccountList["application_id"].intValue : 0
        companyName         = loanAccountList["company_name"] != JSON.null ? loanAccountList["company_name"].stringValue : ""
        createdAt           = loanAccountList["created_at"] != JSON.null ? loanAccountList["created_at"].stringValue : ""
        currentBalance      = loanAccountList["current_balance"] != JSON.null ? loanAccountList["current_balance"].floatValue : 0
        frequency           = loanAccountList["frequency"] != JSON.null ? loanAccountList["frequency"].stringValue : ""
        fundedAmount        = loanAccountList["funded_amount"] != JSON.null ? loanAccountList["funded_amount"].floatValue : 0
        loanAccountsListID  = loanAccountList["id"] != JSON.null ? loanAccountList["id"].intValue : 0
        loanTerms           = loanAccountList["loan_terms"] != JSON.null ? loanAccountList["loan_terms"].stringValue : ""
        paymentAmount       = loanAccountList["payment_amount"] != JSON.null ? loanAccountList["payment_amount"].floatValue : 0
        updatedAt           = loanAccountList["updated_at"] != JSON.null ? loanAccountList["updated_at"].stringValue : ""
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
