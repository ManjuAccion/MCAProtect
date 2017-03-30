//
//  MCAProfileDetails.swift
//  MCAProtect
//
//  Created by Accion Labs on 30/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAProfileDetails: NSObject {
    var contactName : String!
    var businessName : String!
    var contactNumber : String!
    var email : String!
    var profileImageUrl : String!
    var user_Id : String!
    
    init (data : NSDictionary?) {
        
        if nil == data {
            user_Id                     = 233
            contactName                 = "andrew sobers"
            businessName                = "whiteshark tech"
            contactNumber               = "9744794999"
            merchantEmail               = "broker085@gmail.com"
            fieldCount                  = 5
        }
        else {
            
        }
    }


}
