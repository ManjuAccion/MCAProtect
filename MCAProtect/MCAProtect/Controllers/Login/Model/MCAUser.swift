//
//  MCAUser.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/27/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAUser: NSObject {

    var brokerID: String!
    var brokarageFirmID : String!
    var brokerUID : String!
    var brokerEmail : String!
    var brokerContactNumber : String!
    var brokerContactName : String!
    var userType : Int!

    
    
    /*
 {
 "data":
 {
 "id": 6,
 "provider": "email",
 "uid": "broker085@gmail.com",
 "brokerage_firm_id": 1,
 "contact_name": "Test Broker1",
 "business_name": "Ply Woods",
 "email": "broker085@gmail.com",
 "contact_number": "7777777777",
 "profile_picture_file_name": null,
 "profile_picture_content_type": null,
 "profile_picture_file_size": null,
 "profile_picture_updated_at": null,
 "active": true,
 "status": 0,
 "unix_timestamp": 1486983333,
 "admin_id": null,
 "image_url": "https://mcaprotect-dev-storage.s3.amazonaws.com/profile-images/1486979609971-Df3yv7vvkcZvETgG.jpg"
 }
 }
 */
 
 
    init(loginUserData: NSDictionary! , userLoginType: Int)
    {
        
        if nil == loginUserData {
            brokerID      = "Glink Lender"
            brokarageFirmID    = "Glink Lender"
            brokerUID  = "Glink Lender"
            brokerEmail        = "Glink Lender"
            brokerContactNumber       = "Monthly"
            brokerContactName          = "Glink Lender"
            userType = userLoginType
        }
        else
        {
            brokerID            = MCAUtilities.getnilcheckedStringValue(stringToNilCheck: loginUserData.value(forKey: "uid") as! String?)
            brokarageFirmID     = MCAUtilities.getnilcheckedStringValue(stringToNilCheck: loginUserData.value(forKey: "brokerage_firm_id") as! String?)
            brokerUID           = MCAUtilities.getnilcheckedStringValue(stringToNilCheck: loginUserData.value(forKey: "uid") as! String?)
            brokerEmail         =  MCAUtilities.getnilcheckedStringValue(stringToNilCheck: loginUserData.value(forKey: "email") as! String?)
            brokerContactNumber =  MCAUtilities.getnilcheckedStringValue(stringToNilCheck: loginUserData.value(forKey: "contact_number") as! String?)
            brokerContactName   =  MCAUtilities.getnilcheckedStringValue(stringToNilCheck: loginUserData.value(forKey: "contact_name") as! String?)
            userType = userLoginType
        }
    }

    
}
