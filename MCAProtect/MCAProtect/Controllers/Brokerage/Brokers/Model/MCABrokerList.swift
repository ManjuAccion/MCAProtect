//
//  MCABrokerList.swift
//  MCAProtect
//
//  Created by Sarath Neeravallil on 15/05/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCABrokerList: NSObject {
    
    var active                      : Bool!
    var adminId                     : String!
    var applicationsCount           : Int!
    var brokerageFirmId             : Int!
    var businessName                : String!
    var contactName                 : String!
    var contactNumber               : String!
    var createdAt                   : String!
    var email                       : String!
    var id                          : Int!
    var imageUrl                    : String!
    var profilePictureContentType   : AnyObject!
    var profilePictureFileName      : String!
    var profilePictureFileSize      : AnyObject!
    var profilePictureUpdatedAt     : String!
    var provider                    : String!
    var source                      : String!
    var sourceToken                 : String!
    var status                      : Int!
    var uid                         : String!
    var unixTimestamp               : Int!
    var updatedAt                   : String!
    var isSelected                  : Bool!
    
   init(broker: JSON!) {
    
        active                      = broker["active"].boolValue
        adminId                     = broker["admin_id"].stringValue
        applicationsCount           = broker["applications_count"].intValue
        brokerageFirmId             = broker["brokerage_firm_id"].intValue
        businessName                = broker["business_name"].stringValue
        contactName                 = broker["contact_name"].stringValue
        contactNumber               = broker["contact_number"].stringValue
        createdAt                   = broker["created_at"].stringValue
        email                       = broker["email"].stringValue
        id                          = broker["id"].intValue
        imageUrl                    = broker["image_url"].stringValue
        profilePictureContentType   = broker["profile_picture_content_type"].stringValue as AnyObject
        profilePictureFileName      = broker["profile_picture_file_name"].stringValue
        profilePictureFileSize      = broker["profile_picture_file_size"].stringValue as AnyObject
        profilePictureUpdatedAt     = broker["profile_picture_updated_at"].stringValue
        provider                    = broker["provider"].stringValue
        source                      = broker["source"].stringValue
        sourceToken                 = broker["source_token"].stringValue
        status                      = broker["status"].intValue
        uid                         = broker["uid"].stringValue
        unixTimestamp               = broker["unix_timestamp"].intValue
        updatedAt                   = broker["updated_at"].stringValue
    
        isSelected                  = false
    }
}
