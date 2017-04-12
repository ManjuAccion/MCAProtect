//
//  MCAMerchantDocumentation.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAMerchantDocumentation: NSObject {
    
    var documentName            : String!
    var documentDescription     : String!
    var merchantDocumentationID : Int!
    var s3Name                  : String!
    var fieldCount              : Int!

    init(merchantDocumentation: JSON!) {

        merchantDocumentationID     =  merchantDocumentation["id"].intValue
        documentName                =  merchantDocumentation["document_name"].stringValue
        documentDescription         =  merchantDocumentation["document_description"].stringValue
        s3Name                      = merchantDocumentation["s3_name"].stringValue
        
        fieldCount                  = 2
    }

    init(loanApplication: MCALoanApplication!) {
        documentName        = loanApplication.merchantDocumentation.last?.documentName
        documentDescription = loanApplication.merchantDocumentation.last?.documentDescription
        
        fieldCount          = 2
    }
    
    func getValueFromKey(merchantDoumentationKey: MerchantDocumentationKeys) -> String{
        
        var modelValue : String!
        
        switch merchantDoumentationKey {
            case .proofOfIdentity :
                modelValue =  documentName
                
            case .proofOfResidence :
                modelValue = documentDescription
        }
        return modelValue.validatedString()
    }
}
