//
//  MCAAskFunderApplicationList.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/28/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAAskFunderApplicationList: NSObject {

    var name : String!
    var amount : Float!
    
    init(data : NSDictionary?) {
        
        if nil == data {
            name = "Miami Florists"
            amount = 3000
        }
        else {
            
        }
    }
}
