//
//  MCABusinessInformation.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/20/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCABusinessInformation: NSObject {
    
    var bankruptcy                  : Bool!
    var bankruptcyDischargeDate     : AnyObject!
    var bankruptcyMonthlyPayment    : Int!
    var bankruptcyPaymentPlan       : Bool!
    var bankruptcySatisfied         : Bool!
    var businessEntityType          : MCABusinessEntityType!
    var businessSeasonal            : Bool!
    var businessStartDate           : String!
    var dbaBusinessName             : String!
    var federalTaxId                : Int!
    var incorporationState          : MCABillingState!
    var industryType                : MCAIndustryType!
    var judgementsOrLiens           : Bool!
    var judgementsOrLiensAmount     : Int!
    var judgementsOrLiensNo         : Int!
    var legalBusinessName           : String!
    var monthlyPaymentAmount        : Int!
    var paymentPlan                 : Bool!
    var peakMonths                  : String!
    var contactName                 : String!
    var contactNumber               : Int!
    var email                       : String!
    var grossAnnualSales            : Int!
    var businessEntityTypeId        : String!
    var incorporationCountryStateId : Int!
    var industryTypeId              : String!
    var fieldCount                  : Int!

    init(businessInformation: JSON!) {
        
        if businessInformation.isEmpty {
            return
        }
        
        bankruptcy                  = businessInformation["bankruptcy"].boolValue
        bankruptcyDischargeDate     = businessInformation["bankruptcy_discharge_date"].stringValue as AnyObject
        bankruptcyMonthlyPayment    = businessInformation["bankruptcy_monthly_payment"].intValue
        bankruptcyPaymentPlan       = businessInformation["bankruptcy_payment_plan"].boolValue
        bankruptcySatisfied         = businessInformation["bankruptcy_satisfied"].boolValue
        let businessEntityTypeJson  = businessInformation["business_entity_type"]
        
        if !businessEntityTypeJson.isEmpty {
            businessEntityType = MCABusinessEntityType(businessEnityType: businessEntityTypeJson)
        }
        
        businessSeasonal            = businessInformation["business_seasonal"].boolValue
        businessStartDate           = businessInformation["business_start_date"].stringValue
        dbaBusinessName             = businessInformation["dba_business_name"].stringValue
        federalTaxId                = businessInformation["federal_tax_id"].intValue
        let incorporationStateJson  = businessInformation["incorporation_state"]
        
        if !incorporationStateJson.isEmpty {
            incorporationState      = MCABillingState(billingState: incorporationStateJson)
        }
        
        let industryTypeJson        = businessInformation["industry_type"]
        
        if !industryTypeJson.isEmpty {
            industryType            = MCAIndustryType(industryType: industryTypeJson)
        }
        
        judgementsOrLiens           = businessInformation["judgements_or_liens"].boolValue
        judgementsOrLiensAmount     = businessInformation["judgements_or_liens_amount"].intValue
        judgementsOrLiensNo         = businessInformation["judgements_or_liens_no"].intValue
        legalBusinessName           = businessInformation["legal_business_name"].stringValue
        monthlyPaymentAmount        = businessInformation["monthly_payment_amount"].intValue
        paymentPlan                 = businessInformation["payment_plan"].boolValue
        peakMonths                  = businessInformation["peak_months"].stringValue
        
        grossAnnualSales            = 30000 //TODO: Harcoded value need to remove.
        
        fieldCount                  = 12
    }
    
    func getValueFromKey(key: BusinessInformationKeys) -> String{
        
        var modelValue : String!
        
        switch key {
            case .legalBusinessName:
                modelValue =  legalBusinessName
                
            case .contactName:
                modelValue = contactName
                
            case .telephone:
                modelValue = "\(contactNumber!)".toUSPhoneNumberFormat()
                
            case .email:
                modelValue = email
            
            case .federalTaxID:
                modelValue = "\(federalTaxId!)"
            
            case .grossAnnualSales:
                modelValue = MCAUtilities.currencyFormatter(inputItem: grossAnnualSales as AnyObject)
            
            case .businessEntityType:
                modelValue = "\(businessEntityType.businessEntityTypeID!)"
            
            case .dBABusinessName:
                modelValue = dbaBusinessName
            
            case .stateOfIncorprataion:
                modelValue = "\(incorporationState.billingStateID!)"
            
            case .businessStartDate:
                modelValue = businessStartDate
            
            case .industryType:
                modelValue = "\(industryType.industryTypeID!)"
            
            case .seasonalBusiness:
                modelValue = businessSeasonal == true ? "Yes" : "No"
        }
        return modelValue
    }

}
