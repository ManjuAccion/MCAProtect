//
//  MCAMerchantApplicationDetail.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/29/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAMerchantApplicationDetail: NSObject {
    
    var applicationID : Int!
    var acceptedFundingProgramID : Int!
    var contactName : String!
    var businessName : String!
    var contactNumber : String!
    var merchantEmail : String!
    var loanAmount : Float!
    var loanRequirementTenure : String!
    var offeredOn : String!
    var fieldCount : Int!
    
    init(merchantApplicationDetail: JSON!) {
        
        if merchantApplicationDetail.isEmpty {
            
            applicationID               = 233
            acceptedFundingProgramID    = 136
            contactName                 = "andrew sobers"
            businessName                = "whiteshark tech"
            contactNumber               = "9744794999"
            merchantEmail               = "broker085@gmail.com"
            loanAmount                  = 7777.0
            loanRequirementTenure       = "4 days"
            offeredOn                   = "2016-12-12"
            fieldCount                  = 6
            
            return
        }
        
        acceptedFundingProgramID = merchantApplicationDetail["accepted_lending_program_id"] != JSON.null ? merchantApplicationDetail["accepted_lending_program_id"].intValue : 0
        
        businessName = merchantApplicationDetail["business_name"] != JSON.null ? merchantApplicationDetail["business_name"].stringValue : ""
        
        contactName =  merchantApplicationDetail["contact_name"] != JSON.null ? merchantApplicationDetail["contact_name"].stringValue : ""
        
        contactNumber = merchantApplicationDetail["contact_number"] != JSON.null ?   merchantApplicationDetail["contact_number"].stringValue : ""
        
        applicationID = merchantApplicationDetail["id"] != JSON.null ? merchantApplicationDetail["id"].intValue : 0
        
        loanAmount = merchantApplicationDetail["loan_amount"] != JSON.null ? merchantApplicationDetail["loan_amount"].floatValue : 0
        
        loanRequirementTenure =  merchantApplicationDetail["loan_requirement_tenure"] != JSON.null ?merchantApplicationDetail["loan_requirement_tenure"].stringValue : ""
        
        merchantEmail = merchantApplicationDetail["merchant_mail"] != JSON.null ? merchantApplicationDetail["merchant_mail"].stringValue : ""
        
        offeredOn = merchantApplicationDetail["offered_on"] != JSON.null ?  merchantApplicationDetail["offered_on"].stringValue : ""
        fieldCount                  = 6
    }
    
    func getValueFromKey(merchantSummaryKey: MASummaryKeys) -> String {
        
        var modelValue : String!
        
        switch merchantSummaryKey {
            
            case .businessName :
                modelValue =  businessName
                
            case .contactName :
                modelValue = contactName
                
            case .loanAmount :
                modelValue = MCAUtilities.currencyFormatter(inputItem: loanAmount as AnyObject)
                
            case .email :
                modelValue = merchantEmail
                
            case .telephone :
                modelValue = contactNumber
                
            case .offeredOn :
                modelValue = offeredOn
        }
        return modelValue
    }
}
