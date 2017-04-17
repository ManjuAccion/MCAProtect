//
//  MCAFundingProgramList.swift
//  MCAProtect
//
//  Created by Accion Labs on 23/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON


class MCAFundingProgram: NSObject {
    
    var fundingProgramName : String!
    var funderId : Int!
    var contactName : String!
    var term : String!
    var timeInBuisness : String!
    var buyRate : String!
    var creditScore : Int!
    var minimumLoan : Float!
    var maximumLoan : Float!
    var email : String!
    var phoneNumber : String!
    var FPProgramInformation : MCAFPProgramInformation!
    var FPMerchantRquirement : MCAFPMerchantRquirement!
    var FPLiensOrBankruptcy : MCAFPLiensOrBankruptcy!
    var isSelected : Bool!
    
    var fieldCount : Int!

    init(data : JSON!) {
        
        if data != nil {
            
            fundingProgramName      = data["program_type"].stringValue
            contactName             = data["lender"]["contact_name"].stringValue
            term                    = data["max_duration"].stringValue
            timeInBuisness          = data["min_avg_deposit_months"].stringValue
            buyRate                 = data["interest"].stringValue
            creditScore             = data["min_credit_fico"].intValue
            minimumLoan             = data["min_deal_size"].floatValue
            maximumLoan             = data["max_deal_size"].floatValue
            funderId                = data["id"].intValue
            FPProgramInformation    = MCAFPProgramInformation(data : data)
            FPMerchantRquirement    = MCAFPMerchantRquirement(data : data)
            FPLiensOrBankruptcy     = MCAFPLiensOrBankruptcy(Data : data)
            isSelected = false
            
            fieldCount = 8
        }
    }
    
    func getValueFromKey(key: FPApplicationSummaryKeys) -> String{
        
        var modelValue : String!
        
        switch key {
            
            case FPApplicationSummaryKeys.FPSummaryFundingProgram :
                modelValue =  fundingProgramName as String!
            case FPApplicationSummaryKeys.FPSummaryContact :
                modelValue = contactName as String!
            case FPApplicationSummaryKeys.FPSummaryTerm :
                modelValue = term as String!
            case FPApplicationSummaryKeys.FPSummaryTimeInBuisness :
                modelValue = timeInBuisness + " months" as String!
            case FPApplicationSummaryKeys.FPSummaryBuyRate :
                modelValue = buyRate + " %" as String!
            case FPApplicationSummaryKeys.FPSummaryCreditScore :
                modelValue = term as String!
            case FPApplicationSummaryKeys.FPSummaryMinimumLoan :
                modelValue = MCAUtilities.currencyFormatter(inputItem: minimumLoan as AnyObject) as String!
            case FPApplicationSummaryKeys.FPSUmmaryMaximumLoan :
                modelValue = MCAUtilities.currencyFormatter(inputItem: maximumLoan as AnyObject) as String!
            
        }
        return modelValue.validatedString()
    }
}
