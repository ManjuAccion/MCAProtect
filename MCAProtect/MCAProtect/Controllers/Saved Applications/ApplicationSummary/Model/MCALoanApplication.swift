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
        
        if loanApplication.isEmpty {
            return
        }
        
        let addressJson         = loanApplication["address"]
        
        if !addressJson.isEmpty {
            address = MCAAddress(address: addressJson)
        }
        
        bankRecordsLinked       = loanApplication["bank_records_linked"].boolValue
        let businessFinanceJson = loanApplication["business_finance"]
        
        if !businessFinanceJson.isEmpty {
            businessFinance     = MCABusinessFinance(businessFinance: businessFinanceJson)
        }
        
        let businessInfoJson    = loanApplication["business_info"]
        
        if !businessInfoJson.isEmpty {
            businessInfo        = MCABusinessInformation(businessInformation: businessInfoJson)
        }
        
        merchantDocumentation   = [MCAMerchantDocumentation]()
        let merchantDocumentationArray = loanApplication["merchant_documentation"].arrayValue
        
        for merchantDocumentationJson in merchantDocumentationArray {
            let value = MCAMerchantDocumentation(merchantDocumentation: merchantDocumentationJson)
            merchantDocumentation.append(value)
        }
        ownersInfo              = [MCAOwnerInformation]()
        let ownersInfoArray     = loanApplication["owners_info"].arrayValue
        
        for ownersInfoJson in ownersInfoArray {
            let value = MCAOwnerInformation(ownerInformation: ownersInfoJson)
            ownersInfo.append(value)
        }
        
        let programInfoJson     = loanApplication["program_info"]
        
        if !programInfoJson.isEmpty {
            programInfo         = MCAProgramInformation(programInformation: programInfoJson)
        }
    }
}
