//
//  MCAFPLiensOrBankruptcy.swift
//  MCAProtect
//
//  Created by Accion Labs on 27/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFPLiensOrBankruptcy: NSObject {
    
    
    var judegementsORLiens : String!
    var numberOfJudementsOrLiens : String!
    var maxLiensOrJudgementAmount : String!
    var isBankruptcyAllowed : String!
    var paymentPlan  : String!
    var montlyPaymentAllowed : String!
    var merchantSatisfiedBankruptcy : String!
    var dischargedBankruptcy : String!
    var fieldCount : Int!

    
    init(data : NSDictionary?) {
        
        if data != nil {
            
        }
        else
        {
            judegementsORLiens = "Syndicate Premium"
            numberOfJudementsOrLiens = "10 Months"
            maxLiensOrJudgementAmount = "5000"
            isBankruptcyAllowed = "40000"
            paymentPlan = "1.29%"
            montlyPaymentAllowed = "5%"
            merchantSatisfiedBankruptcy = "10%"
            dischargedBankruptcy = "When Discharged from Bankruptcy?"
            fieldCount = 8
            
            
        }
    }
    
    
    func getValueFromKey(key: FPLiensAndBankruptcyKeys) -> String{
        
        var modelValue : String!
        
        switch key {
        case .FPJudegementsORLiens :
            modelValue =  judegementsORLiens
            
        case .FPNumberOfJudementsOrLiens :
            modelValue = numberOfJudementsOrLiens
            
        case .FPMaxLiensOrJudgementAmount :
            modelValue = maxLiensOrJudgementAmount
            
        case .FPIsBankruptcyAllowed :
            modelValue = isBankruptcyAllowed
            
        case .FPPaymentPlan :
            modelValue = paymentPlan
            
        case .FPMontlyPaymentAllowed :
            modelValue = montlyPaymentAllowed
            
        case .FPMerchantSatisfiedBankruptcy :
            modelValue = merchantSatisfiedBankruptcy
            
        case .FPDischargedBankruptcy :
            modelValue = dischargedBankruptcy

            
        }
        return modelValue
    }


}
