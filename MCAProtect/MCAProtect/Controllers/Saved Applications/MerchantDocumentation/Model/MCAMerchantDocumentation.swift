//
//  MCAMerchantDocumentation.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMerchantDocumentation: NSObject {
    
    var proofOfIdentity : String!
    var proofOfResidence : String!
    var fieldCount : Int!
    
    init(data : NSDictionary?) {
        if nil == data {
            proofOfIdentity = "Passport"
            proofOfResidence = "Utility Bill"
            fieldCount = 2
        }
        else {
            
        }
    }

    func getValueFromKey(merchantDoumentationKey: MerchantDocumentationKeys) -> String{
        
        var modelValue : String!
        
        switch merchantDoumentationKey {
            case .proofOfIdentity :
                modelValue =  proofOfIdentity
                
            case .proofOfResidence :
                modelValue = proofOfResidence
            
        }
        return modelValue
    }
}
