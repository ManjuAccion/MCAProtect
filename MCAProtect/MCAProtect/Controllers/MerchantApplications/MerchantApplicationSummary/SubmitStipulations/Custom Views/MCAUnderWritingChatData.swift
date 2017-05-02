//
//  MCAUnderWritingChatData.swift
//  MCAProtect
//
//  Created by Accion Labs on 02/05/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAUnderWritingChatData: NSObject {

    var applicationID               : Int!
    var fundingProgramID            : Int!
    var messageText                 : String!
    var userImageUrl                : String!
    var chatType                    : String!
    var brokerID                    : String!
    var userName                     : String!
    var createdDate                : String!
    var updatedDate                   : String!
    var userType                     : String!
    var messsageRead                     : Bool!

    var fieldCount                  : Int!
    
    init(underWritingChatData: JSON!) {
        
        fundingProgramID             = underWritingChatData["lending_program_id"].intValue
        messageText                  = underWritingChatData["message"].stringValue
        userImageUrl                 = underWritingChatData["user_image_url"].stringValue
        chatType                     = underWritingChatData["chat_type"].stringValue
        applicationID                = underWritingChatData["application_id"].intValue
        brokerID                     = underWritingChatData["user_id"].stringValue
        userName                     = underWritingChatData["user_name"].stringValue
        createdDate                  = underWritingChatData["created_at"].stringValue
        updatedDate                  = underWritingChatData["updated_at"].stringValue
        userType                     = underWritingChatData["user_type"].stringValue
        messsageRead                 = underWritingChatData["message_read"].boolValue


        fieldCount                  = 11
    }

}
