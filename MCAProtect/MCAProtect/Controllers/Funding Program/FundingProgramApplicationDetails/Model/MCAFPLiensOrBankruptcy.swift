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
    
    
    var judegementsORLiens :  Bool!
    var numberOfJudementsOrLiens : String!
    var maxLiensOrJudgementAmount : String!
    var isBankruptcyAllowed : Bool!
    var paymentPlan  : Bool!
    var montlyPaymentAllowed : String!
    var merchantSatisfiedBankruptcy : String!
    var dischargedBankruptcy : String!
    var fieldCount : Int!

    
    init(Data : JSON!) {
        
        if Data != nil {
            judegementsORLiens = Data["allow_liens_adjustments"].boolValue
            
            numberOfJudementsOrLiens = Data["no_of_liens_adjustments"] != JSON.null ? Data["no_of_liens_adjustments"].stringValue : ""
            maxLiensOrJudgementAmount = Data["total_lien_amount"] != JSON.null ? Data["total_lien_amount"].stringValue : ""
            isBankruptcyAllowed = Data["merchant_satisfied_bankruptcy"].boolValue
            paymentPlan = Data["merchant_in_payment_plan"].boolValue
           montlyPaymentAllowed = Data["allowed_monthly_payment"] != JSON.null ? Data["allowed_monthly_payment"].stringValue : ""
           merchantSatisfiedBankruptcy = Data["merchant_satisfied_bankruptcy"] != JSON.null ? Data["merchant_satisfied_bankruptcy"].stringValue : ""
            dischargedBankruptcy = Data["bankruptcy_discharge_date"] != JSON.null ? Data["bankruptcy_discharge_date"].stringValue : ""
            
            fieldCount = 8

        }
           }
    
    
    func getValueFromKey(key: FPLiensAndBankruptcyKeys) -> String{
        
        var modelValue : AnyObject!
        
        switch key {
        case .FPJudegementsORLiens :
            modelValue =  judegementsORLiens as AnyObject!
            
        case .FPNumberOfJudementsOrLiens :
            modelValue = numberOfJudementsOrLiens as AnyObject!
            
        case .FPMaxLiensOrJudgementAmount :
            modelValue = maxLiensOrJudgementAmount as AnyObject!
            
        case .FPIsBankruptcyAllowed :
            modelValue = isBankruptcyAllowed as AnyObject!
            
        case .FPPaymentPlan :
            modelValue = paymentPlan as AnyObject!
            
        case .FPMontlyPaymentAllowed :
            modelValue = montlyPaymentAllowed as AnyObject!
            
        case .FPMerchantSatisfiedBankruptcy :
            modelValue = merchantSatisfiedBankruptcy as AnyObject!
            
        case .FPDischargedBankruptcy :
            modelValue = dischargedBankruptcy as AnyObject!

            
        }
        return (modelValue as AnyObject) as! String
    }


}
