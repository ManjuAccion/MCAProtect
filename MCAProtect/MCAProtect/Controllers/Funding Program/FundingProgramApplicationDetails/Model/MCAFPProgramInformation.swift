//
//  MCAFPProgramInformation.swift
//  MCAProtect
//
//  Created by Accion Labs on 27/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFPProgramInformation: NSObject {
    
    
    var programInformationName : String!
    var maxTerm : String!
    var minimumLoanAmount : Int!
    var maximumLoanAmount : Int!
    var buyRate : String!
    var maxUpsellRate : String!
    var maxGrossRevenue : String!
    var originalFee : String!
    var loanType : String!
    var installmentType : String!
    var loanPosition : String!
    var loanAgreement : String!
    var fieldCount : Int!
    
    
    
    init(data : NSDictionary?) {
        
        if data != nil {
            
        }
        else
        {
            programInformationName = "Syndicate Premium"
            maxTerm = "10 Months"
            minimumLoanAmount = 5000
            maximumLoanAmount = 40000
            buyRate = "1.29%"
            maxUpsellRate = "5%"
            maxGrossRevenue = "10%"
            originalFee = "$50"
            loanType = "ACH"
            installmentType = "Weekly"
            loanPosition = "Any Position"
            loanAgreement = "Yes"
            fieldCount = 12
            
            
        }
    }

    
    func getValueFromKey(key: FPProgramInformationKeys) -> String{
        
        var modelValue : String!
        
        switch key {
        case .FPProgramInformation :
            modelValue =  programInformationName
            
        case .FPMaxTerm :
            modelValue = maxTerm
            
        case .FPMinimumLoanAmount :
            modelValue = MCAUtilities.currencyFormatter(inputItem: minimumLoanAmount as AnyObject)
            
        case .FPMaximumLoanAmount :
            modelValue = MCAUtilities.currencyFormatter(inputItem: maximumLoanAmount as AnyObject)

            
        case .FPBuyRate :
            modelValue = buyRate
            
        case .FPMaxUPSellRate :
            modelValue = maxUpsellRate
            
        case .FPMaxGrossRevenue :
            modelValue = maxGrossRevenue
            
        case .FPOriginationFee :
            modelValue = originalFee
            
        case .FPLoanType :
            modelValue = loanType
            
        case .FPInstallmentType :
            modelValue = installmentType
            
        case .FPAcceptLoanPosition :
            modelValue = maxGrossRevenue
            
        case .FPLoanAgreement :
            modelValue = loanAgreement
        }
        return modelValue
    }

}
