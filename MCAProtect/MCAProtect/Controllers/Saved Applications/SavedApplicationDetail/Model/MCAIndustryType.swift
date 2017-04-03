//
//  MCAIndustryType.swift
//  MCAProtect
//
//  Created by Sarath N S on 03/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAIndustryType: NSObject {
    
    var createdAt       : String!
    var industryTypeID  : Int!
    var sicCode         : String!
    var typeName        : String!
    var updatedAt       : String!
    
    init(industryType : JSON!) {
        
        if industryType.isEmpty {
            return
        }
        
        createdAt       = industryType["created_at"].stringValue
        industryTypeID  = industryType["id"].intValue
        sicCode         = industryType["sic_code"].stringValue
        typeName        = industryType["type_name"].stringValue
        updatedAt       = industryType["updated_at"].stringValue
    }
}
