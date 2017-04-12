//
//  MCALoanApplication.swift
//  MCAProtect
//
//  Created by Sarath N S on 03/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCALoanApplication: NSObject {
    
    var address                 : MCAAddress!
    var bankRecordsLinked       : Bool!
    var businessFinance         : MCABusinessFinance!
    var businessInfo            : MCABusinessInformation!
    var merchantDocumentation   : [MCAMerchantDocumentation]!
    var ownersInfo              : [MCAOwnerInformation]!
    var programInfo             : MCAProgramInformation!
    
    init(loanApplication : JSON!) {
        
        let addressJson                 = loanApplication["address"]
        address                         = MCAAddress(address: addressJson)
        bankRecordsLinked               = loanApplication["bank_records_linked"].boolValue
        let businessFinanceJson         = loanApplication["business_finance"]
        businessFinance                 = MCABusinessFinance(businessFinance: businessFinanceJson)
        let programInfoJson             = loanApplication["program_info"]
        programInfo                     = MCAProgramInformation(programInformation: programInfoJson)
        let businessInfoJson            = loanApplication["business_info"]
        businessInfo                    = MCABusinessInformation(businessInformation: businessInfoJson)
        businessInfo.contactName        = programInfo.contactName
        businessInfo.contactNumber      = programInfo.contactNumber
        businessInfo.email              = programInfo.email
        businessInfo.grossAnnualSales   = businessFinance.grossAnnualSales
        businessInfo.grossAnnualRevenue = businessFinance.revenueAmount
        merchantDocumentation           = [MCAMerchantDocumentation]()
        let merchantDocumentationArray  = loanApplication["merchant_documentation"].arrayValue
        
        for merchantDocumentationJson in merchantDocumentationArray {
            let value = MCAMerchantDocumentation(merchantDocumentation: merchantDocumentationJson)
            merchantDocumentation.append(value)
        }
        
        ownersInfo                      = [MCAOwnerInformation]()
        let ownersInfoArray             = loanApplication["owners_info"].arrayValue
        
        for ownersInfoJson in ownersInfoArray {
            let value = MCAOwnerInformation(ownerInformation: ownersInfoJson)
            ownersInfo.append(value)
        }
    }
}
