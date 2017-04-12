//
//  MCAFundingProgramList.swift
//  MCAProtect
//
//  Created by Accion Labs on 23/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON


class MCAFundingProgramList: NSObject {
    
    var fundingProgramName : String!
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
            FPProgramInformation    = MCAFPProgramInformation(data : data)
            FPMerchantRquirement    = MCAFPMerchantRquirement(data : data)
            FPLiensOrBankruptcy     = MCAFPLiensOrBankruptcy(Data : data)
            
            fieldCount = 8
        }
    }
    
    func getValueFromKey(key: FPApplicationSummaryKeys) -> AnyObject{
        
        var modelValue : AnyObject!
        
        switch key {
            
            case FPApplicationSummaryKeys.FPSummaryFundingProgram :
                modelValue =  fundingProgramName as AnyObject!
            case FPApplicationSummaryKeys.FPSummaryContact :
                modelValue = contactName as AnyObject!
            case FPApplicationSummaryKeys.FPSummaryTerm :
                modelValue = term as AnyObject!
            case FPApplicationSummaryKeys.FPSummaryTimeInBuisness :
                modelValue = timeInBuisness as AnyObject!
            case FPApplicationSummaryKeys.FPSummaryBuyRate :
                modelValue = buyRate as AnyObject!
            case FPApplicationSummaryKeys.FPSummaryCreditScore :
                modelValue = term as AnyObject!
            case FPApplicationSummaryKeys.FPSummaryMinimumLoan :
                modelValue = MCAUtilities.currencyFormatter(inputItem: minimumLoan as AnyObject) as AnyObject!
            case FPApplicationSummaryKeys.FPSUmmaryMaximumLoan :
                modelValue = MCAUtilities.currencyFormatter(inputItem: maximumLoan as AnyObject) as AnyObject!
            
        }
        return modelValue
    }
}
