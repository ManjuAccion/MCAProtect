//
//  MCABusinessEntityType.swift
//  MCAProtect
//
//  Created by Sarath N S on 03/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCABusinessEntityType: NSObject {
    
    var createdAt               : String!
    var businessEntityTypeID    : Int!
    var name                    : String!
    var updatedAt               : String!
    
    init(businessEnityType: JSON!) {
        
        createdAt               = businessEnityType["created_at"].stringValue
        businessEntityTypeID    = businessEnityType["id"].intValue
        name                    = businessEnityType["name"].stringValue
        updatedAt               = businessEnityType["updated_at"].stringValue
    }
}
