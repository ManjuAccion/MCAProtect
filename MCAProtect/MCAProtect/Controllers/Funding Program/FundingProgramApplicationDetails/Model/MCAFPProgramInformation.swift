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
    
    
    
    init(Data : JSON!) {
        
        if Data != nil {
            
            programInformationName = Data["program_type"] != JSON.null ? Data["program_type"].stringValue : ""
            
            maxTerm = Data["max_term"] != JSON.null ? Data["max_term"].stringValue : ""
            
            minimumLoanAmount =  Data["min_deal_size"] != JSON.null ? Data["min_deal_size"].intValue : 0
            
            maximumLoanAmount =  Data["max_deal_size"] != JSON.null ? Data["max_deal_size"].intValue : 0
            
            buyRate = Data["interest"] != JSON.null ? Data["interest"].stringValue : ""
            
            maxUpsellRate = Data["allowed_broker_commision"] != JSON.null ? Data["allowed_broker_commision"].stringValue : ""
            
            maxGrossRevenue = Data["percentage_of_gross_revenue"] != JSON.null ? Data["percentage_of_gross_revenue"].stringValue : ""
            
            originalFee = Data["origination_fee"] != JSON.null ? Data["origination_fee"].stringValue : ""
            
            loanType = Data["loan_type"] != JSON.null ? Data["loan_type"].stringValue : ""
            
            installmentType = Data["installment_type"] != JSON.null ? Data["installment_type"].stringValue : ""
            
            loanPosition = Data["loan_position"] != JSON.null ? Data["loan_position"].stringValue : ""
            
            loanAgreement = Data["loan_agreement_url"] != JSON.null ? Data["loan_agreement_url"].stringValue : ""
            
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
