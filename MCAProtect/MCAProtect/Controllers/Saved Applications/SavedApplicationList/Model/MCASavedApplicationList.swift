//
//  MCASavedApplicationList.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASavedApplicationList: NSObject {
    
    var applicationName : String!
    var amount : Float!
    var merchantName : String!
    var merchantEmail : String!
    var merchantPhoneNumber : String!
    var neededIn : Int!

    init(data : NSDictionary?) {
        
        if nil == data {
            applicationName = "Miami Florists"
            amount = 5000
            merchantName = "Paul Thomson"
            merchantEmail = "paul.t@gmail.com"
            merchantPhoneNumber = "+44 7415554422"
            neededIn = 12
        }
        else {
            
        }
    }
}
