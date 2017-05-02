//
//  MCAChatBubbleData.swift
//  MCAProtect
//
//  Created by Accion Labs on 30/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

enum BubbleDataType: Int{
    case mine = 0
    case opponent
}

/// DataModel for maintaining the message data for a single chat bubble
class MCAChatBubbleData {
    // 2.Properties
    var text: String?
    var image: UIImage?
    var date: Date?
    var profileImageUrl : String?
    var type: BubbleDataType
    
    // 3. Initialization
    init(text: String?,image: UIImage?,date: Date? , type:BubbleDataType = .mine,profileImageUrl: String?) {
        // Default type is Mine
        self.text = text
        self.image = image
        self.date = date
        self.type = type
        self.profileImageUrl = profileImageUrl
    }
}
