//
//  MCAOwnerInformation.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAOwnerInformation: NSObject {
    
    var ownerName : String?
    var socialSecurityNumber : String?
    
    init(data :NSDictionary?) {
        
        if nil == data {
            ownerName = "Randell D'souza"
            socialSecurityNumber = "666777888"
        }
        else {
            
        }
    }

}
