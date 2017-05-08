//
//  MCANotificationData.swift
//  MCAProtect
//
//  Created by Accion Labs on 08/05/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCANotificationData: NSObject {

    
    var applicationID           : String!
    var brokerID                : String!
    var notificationType        : String!
    var dataSent                : String!
    var updatedDate             : String!
    var notificationID           : String!


    var readStatus              : Int!

    
    
    
    init(data : JSON!) {
        
    
        if data != nil {
            
            applicationID  = data["application_id"].stringValue
            brokerID                 = data["broker_id"].stringValue
            notificationType                 = data["notification_type"].stringValue
            dataSent           = data["data_sent"].stringValue
            readStatus           = data["read_status"].intValue
            updatedDate        = data["updated_at"].stringValue
            notificationID        = data["id"].stringValue

                    }
    }

}
