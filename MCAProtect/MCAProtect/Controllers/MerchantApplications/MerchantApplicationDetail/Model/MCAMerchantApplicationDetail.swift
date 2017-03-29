//
//  MCAMerchantApplicationDetail.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/29/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

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
    
    init (data : NSDictionary?) {
        
        if nil == data {
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
        }
        else {
            
        }
    }
    
    func getValueFromKey(merchantSummaryKey: MASummaryKeys) -> String{
        
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
