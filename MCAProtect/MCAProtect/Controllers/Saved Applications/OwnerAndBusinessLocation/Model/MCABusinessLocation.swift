//
//  MCABusinessLocation.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/27/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABusinessLocation: NSObject {

    var businessLocation : String?
    var locationName : String?
    
    init(data :NSDictionary?) {
        
        if nil == data {
            businessLocation = "Business Location 1"
            locationName = "Alexander City"
        }
        else {
            
        }
    }

}
