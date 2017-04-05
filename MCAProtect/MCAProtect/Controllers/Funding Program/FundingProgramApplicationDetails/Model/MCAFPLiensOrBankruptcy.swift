//
//  MCAFPLiensOrBankruptcy.swift
//  MCAProtect
//
//  Created by Accion Labs on 27/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import  SwiftyJSON

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

    
    init(Data : JSON!) {
        
        if Data != nil {
            judegementsORLiens = Data["allow_liens_adjustments"] != JSON.null ? Data["allow_liens_adjustments"].stringValue : ""
            numberOfJudementsOrLiens = Data["no_of_liens_adjustments"] != JSON.null ? Data["no_of_liens_adjustments"].stringValue : ""
            maxLiensOrJudgementAmount = Data["total_lien_amount"] != JSON.null ? Data["total_lien_amount"].stringValue : ""
            isBankruptcyAllowed = Data["merchant_satisfied_bankruptcy"] != JSON.null ? Data["merchant_satisfied_bankruptcy"].stringValue : ""
            paymentPlan = Data["merchant_in_payment_plan"] != JSON.null ? Data["merchant_in_payment_plan"].stringValue : ""
           montlyPaymentAllowed = Data["allowed_monthly_payment"] != JSON.null ? Data["allowed_monthly_payment"].stringValue : ""
           merchantSatisfiedBankruptcy = Data["merchant_satisfied_bankruptcy"] != JSON.null ? Data["merchant_satisfied_bankruptcy"].stringValue : ""
            dischargedBankruptcy = Data["bankruptcy_discharge_date"] != JSON.null ? Data["bankruptcy_discharge_date"].stringValue : ""
            
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
