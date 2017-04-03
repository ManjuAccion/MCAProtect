//
//  MCAOwnerInformation.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAOwnerInformation: NSObject {
    
    var address : String!
    var city : String!
    var dob : String!
    var email : String!
    var firstName : String!
    var homeTelephone : String!
    var ownerInformationID : Int!
    var lastName : String!
    var percentageOwned : Int!
    var ssnNumber : String!
    var state : MCABillingState!
    var title : String!
    var zipcode : String!
    
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
    
    init(ownerInformation: JSON!) {
        
        if ownerInformation.isEmpty {
         
            return
        }
        address = ownerInformation["address1"].stringValue
        city = ownerInformation["city"].stringValue
        dob = ownerInformation["dob"].stringValue
        email = ownerInformation["email"].stringValue
        firstName = ownerInformation["first_name"].stringValue
        homeTelephone = ownerInformation["home_telephone"].stringValue
        ownerInformationID = ownerInformation["id"].intValue
        lastName = ownerInformation["last_name"].stringValue
        percentageOwned = ownerInformation["percentage_owned"].intValue
        ssnNumber = ownerInformation["ssn_number"].stringValue
        let stateJson = ownerInformation["state"]
        if !stateJson.isEmpty{
            state = MCABillingState(billingState: stateJson)
        }
        title = ownerInformation["title"].stringValue
        zipcode = ownerInformation["zipcode"].stringValue
    }

}
