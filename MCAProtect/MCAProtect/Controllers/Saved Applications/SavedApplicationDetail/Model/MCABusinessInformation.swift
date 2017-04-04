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
    
    
    //TODO: - Need to remove the old data 
    
    var contactName : String!
    var contactNumber : String!
    var email : String!
    var grossAnnualSales : Int!
    var businessEntityTypeId : String!
    var incorporationCountryStateId : Int!
    var industryTypeId : String!
    var fieldCount : Int!

    
    init(data : NSDictionary?) {
        if nil == data {
            legalBusinessName   = "Stacy's Boutique"
            contactName         = "Harry Parker"
            contactNumber       = "(876) 965-8756"
            email               = "harry.parker@yahoo.com"
            federalTaxId        = 8768967
            grossAnnualSales    = 30000
            businessEntityTypeId = "Patnership"
            dbaBusinessName     = "Stacy's Boutique"
            incorporationCountryStateId = 1
            businessStartDate   = "2014-12-09"
            industryTypeId      = "Ice Cream"
            businessSeasonal    = true
            fieldCount          = 12
        }
        else {
            
        }
    }
    
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
        
        if !businessEntityTypeJson.isEmpty{
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
        
        grossAnnualSales    = 30000

    }
    

    
    
    
    init(loanApplication: MCALoanApplication) {
        
        
        bankruptcy                  = loanApplication.businessInfo.bankruptcy
        bankruptcyDischargeDate     = loanApplication.businessInfo.bankruptcyDischargeDate
        bankruptcyMonthlyPayment    = loanApplication.businessInfo.bankruptcyMonthlyPayment
        bankruptcyPaymentPlan       = loanApplication.businessInfo.bankruptcyPaymentPlan
        bankruptcySatisfied         = loanApplication.businessInfo.bankruptcySatisfied
        businessEntityType          = loanApplication.businessInfo.businessEntityType
        
        businessSeasonal            = loanApplication.businessInfo.businessSeasonal
        businessStartDate           = loanApplication.businessInfo.businessStartDate
        dbaBusinessName             = loanApplication.businessInfo.dbaBusinessName
        federalTaxId                = loanApplication.businessInfo.federalTaxId
        
        incorporationState          = loanApplication.businessInfo.incorporationState
        
        industryType                = loanApplication.businessInfo.industryType
        
        judgementsOrLiens           = loanApplication.businessInfo.judgementsOrLiens
        judgementsOrLiensAmount     = loanApplication.businessInfo.judgementsOrLiensAmount
        judgementsOrLiensNo         = loanApplication.businessInfo.judgementsOrLiensNo
        legalBusinessName           = loanApplication.businessInfo.legalBusinessName
        monthlyPaymentAmount        = loanApplication.businessInfo.monthlyPaymentAmount
        paymentPlan                 = loanApplication.businessInfo.paymentPlan
        peakMonths                  = loanApplication.businessInfo.peakMonths
        contactNumber               = "\(loanApplication.programInfo.contactNumber!)"
        contactName                 = loanApplication.programInfo.contactName
        email                       = loanApplication.programInfo.email
        
        grossAnnualSales    = 30000

        fieldCount          = 12

    }
    
    
    
    func getValueFromKey(key: BusinessInformationKeys) -> String{
        
        var modelValue : String!
        
        switch key {
            case .legalBusinessName:
                modelValue =  legalBusinessName
                
            case .contactName:
                modelValue = contactName
                
            case .telephone:
                modelValue = contactNumber
                
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
                modelValue = "true" //TODO: Need to remove the hardcodes.
            
        }
        return modelValue
    }

}
