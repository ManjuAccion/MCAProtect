//
//  MCADealsPipeLine.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/29/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCADealsPipeLine: NSObject {
    
    var applicationStateID : Int!
    var applicationStateName : String!
    var applicationCount : Int!
    var sum : Float!
    var average : Float!
    var dealsFunded : Int!
    
    init(data : NSDictionary?) {
        
        if nil == data {
            applicationStateID = 1
            applicationStateName = "New"
            applicationCount = 5
            sum = 85887.0
            average = 14314.5
            dealsFunded  = 0
        }
        else {
            
        }
    }
}
