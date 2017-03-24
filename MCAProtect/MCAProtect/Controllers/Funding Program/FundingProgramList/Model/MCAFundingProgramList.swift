//
//  MCAFundingProgramList.swift
//  MCAProtect
//
//  Created by Accion Labs on 23/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

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
    
    var fieldCount : Int!


    
    init(Data : NSDictionary?) {
        
        if Data != nil {
            
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
