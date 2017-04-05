//
//  MCAProgramInformation.swift
//  MCAProtect
//
//  Created by Sarath N S on 03/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAProgramInformation: NSObject {
    
    var applicationID : Int!
    var businessName : String!
    var contactName : String!
    var contactNumber : Int!
    var creditScore : Int!
    var email : String!
    var isSubmit : Bool!
    var loanAmount : Int!
    var loanPurpose : String!
    var loanRequirementTenure : String!
    var loanTerm : Int!
    var token : String!
    var loanDetailFieldCount : Int!
    
    
    init(programInformation: JSON!) {
        
        if programInformation.isEmpty {
            
            return
        }
        applicationID = programInformation["application_id"].intValue
        businessName = programInformation["business_name"].stringValue
        contactName = programInformation["contact_name"].stringValue
        contactNumber = programInformation["contact_number"].intValue
        creditScore = programInformation["credit_score"].intValue
        email = programInformation["email"].stringValue
        isSubmit = programInformation["is_submit"].boolValue
        loanAmount = programInformation["loan_amount"].intValue
        loanPurpose = programInformation["loan_purpose"].stringValue
        loanRequirementTenure = programInformation["loan_requirement_tenure"].stringValue
        loanTerm = programInformation["loan_term"].intValue
        token = programInformation["token"].stringValue
        loanDetailFieldCount = 5
    }
    
    
    func getLoanDetailsFromProgramInformation(loanDetailKey:LoanDetailKeys) -> String {
        
        var modelValue : String!
        
        switch loanDetailKey {
            
        case .businessName :
            modelValue =  businessName
            
        case .loanAmount :
            modelValue = MCAUtilities.currencyFormatter(inputItem: loanAmount as AnyObject)
            
        case .creditScore :
            modelValue = "\(creditScore!)"
            
        case .needItBy :
            modelValue = loanRequirementTenure
            
        case .loanTerm :
            modelValue = "\(loanTerm!) Months"
        }
        return modelValue
    }
}



