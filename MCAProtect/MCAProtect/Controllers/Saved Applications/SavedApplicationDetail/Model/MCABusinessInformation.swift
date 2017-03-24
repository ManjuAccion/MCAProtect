//
//  MCABusinessInformation.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/20/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABusinessInformation: NSObject {
    
    var legalBusinessName : String!
    var contactName : String!
    var contactNumber : String!
    var email : String!
    var federalTaxId : String!
    var grossAnnualSales : Int!
    var businessEntityTypeId : String!
    var dbaBusinessName : String!
    var incorporationCountryStateId : Int!
    var businessStartDate : String!
    var industryTypeId : String!
    var businessSeasonal : String!
    var fieldCount : Int!

    
    init(data : NSDictionary?) {
        if nil == data {
            legalBusinessName   = "Stacy's Boutique"
            contactName         = "Harry Parker"
            contactNumber       = "(876) 965-8756"
            email               = "harry.parker@yahoo.com"
            federalTaxId        = "8768967"
            grossAnnualSales    = 30000
            businessEntityTypeId = "Patnership"
            dbaBusinessName     = "Stacy's Boutique"
            incorporationCountryStateId = 1
            businessStartDate   = "2014-12-09"
            industryTypeId      = "Ice Cream"
            businessSeasonal    = "Yes"
            fieldCount          = 12
        }
        else {
            
        }
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
                modelValue = federalTaxId
            
            case .grossAnnualSales:
                modelValue = "\(grossAnnualSales!)"
            
            case .businessEntityType:
                modelValue = businessEntityTypeId
            
            case .dBABusinessName:
                modelValue = dbaBusinessName
            
            case .stateOfIncorprataion:
                modelValue = "\(incorporationCountryStateId!)"
            
            case .businessStartDate:
                modelValue = businessStartDate
            
            case .industryType:
                modelValue = industryTypeId
            
            case .seasonalBusiness:
                modelValue = businessSeasonal
            
        }
        return modelValue
    }

}
