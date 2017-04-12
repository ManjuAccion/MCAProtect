//
//  MCAFPProgramInformation.swift
//  MCAProtect
//
//  Created by Accion Labs on 27/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAFPProgramInformation: NSObject {
    
    var programInformationName  : String!
    var maxTerm                 : String!
    var minimumLoanAmount       : Int!
    var maximumLoanAmount       : Int!
    var buyRate                 : String!
    var maxUpsellRate           : String!
    var maxGrossRevenue         : String!
    var originalFee             : String!
    var loanType                : String!
    var installmentType         : String!
    var loanPosition            : String!
    var loanAgreement           : String!
    var fieldCount              : Int!
    
    
    
    init(data : JSON!) {
        
        if data != nil {
            
            programInformationName  = data["program_type"].stringValue
            maxTerm                 = data["max_term"].stringValue
            minimumLoanAmount       = data["min_deal_size"].intValue
            maximumLoanAmount       = data["max_deal_size"].intValue
            buyRate                 = data["interest"].stringValue + "%"
            maxUpsellRate           = data["allowed_broker_commision"].stringValue + "%"
            maxGrossRevenue         = data["percentage_of_gross_revenue"].stringValue + "%"
            originalFee             = data["origination_fee"].stringValue
            loanType                = data["loan_type"].stringValue
            installmentType         = data["installment_type"].stringValue
            loanPosition            = data["loan_position"].stringValue
            loanAgreement           = data["loan_agreement_url"].stringValue
            
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
        return modelValue.validatedString()
    }

}
