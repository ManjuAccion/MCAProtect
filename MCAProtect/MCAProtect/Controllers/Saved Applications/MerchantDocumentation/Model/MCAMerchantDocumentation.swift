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
    
    var documentName : String!
    var documentDescription : String!
    var merchantDocumentationID : Int!
    var s3Name : String!
    var fieldCount : Int!

    
    init(merchantDocumentation: JSON!) {
        
        if merchantDocumentation.isEmpty {
            documentName = "Passport"
            documentDescription = "Utility Bill"
            fieldCount = 2
            return
        }
        else {
            merchantDocumentationID = merchantDocumentation["id"] != JSON.null ? merchantDocumentation["id"].intValue : 0
            documentName = merchantDocumentation["document_name"] != JSON.null ? merchantDocumentation["document_name"].stringValue : ""
            documentDescription = merchantDocumentation["document_description"] != JSON.null ? merchantDocumentation["document_description"].stringValue : ""
            s3Name = merchantDocumentation["s3_name"] != JSON.null ? merchantDocumentation["s3_name"].stringValue : ""
            fieldCount = 2
        }
    }

    func getValueFromKey(merchantDoumentationKey: MerchantDocumentationKeys) -> String{
        
        var modelValue : String!
        
        switch merchantDoumentationKey {
            case .proofOfIdentity :
                modelValue =  documentName
                
            case .proofOfResidence :
                modelValue = documentDescription
        }
        return modelValue
    }
}
