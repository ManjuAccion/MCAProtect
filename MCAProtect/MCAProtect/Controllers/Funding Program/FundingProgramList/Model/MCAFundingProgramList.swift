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


    
    init(Data : JSON!) {
        
        if Data != nil {
            
            fundingProgramName = Data["program_type"] != JSON.null ? Data["program_type"].stringValue : ""
            
            contactName = Data["lender"]["contact_name"] != JSON.null ? Data["lender"]["contact_name"].stringValue : ""
            
            term = Data["max_duration"] != JSON.null ? Data["max_duration"].stringValue : ""
            
            timeInBuisness = Data["min_avg_deposit_months"] != JSON.null ? Data["min_avg_deposit_months"].stringValue : ""
            
            buyRate = Data["interest"] != JSON.null ? Data["interest"].stringValue : ""
            
            creditScore = Data["min_credit_fico"] != JSON.null ? Data["min_credit_fico"].intValue : 0

            
            minimumLoan = Data["min_deal_size"] != JSON.null ? Data["min_deal_size"].floatValue : 0.0
            
            maximumLoan = Data["max_deal_size"] != JSON.null ? Data["max_deal_size"].floatValue : 0.0

            FPProgramInformation = MCAFPProgramInformation(Data : Data)
            FPMerchantRquirement = MCAFPMerchantRquirement(Data : Data)
            FPLiensOrBankruptcy = MCAFPLiensOrBankruptcy(Data : Data)
            
           
            fieldCount = 8

           
        }
        else
        {
            
            fundingProgramName = "Stacy's Botique"
            contactName = "Syndicate Premium"
            term = "18 months"
            timeInBuisness = "6 months"
            buyRate = "%1.28"
            creditScore = 650
            minimumLoan = 2000
            maximumLoan = 10000
            email = "halen@gmail.com"
            phoneNumber = "+(44)7432345678"
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
