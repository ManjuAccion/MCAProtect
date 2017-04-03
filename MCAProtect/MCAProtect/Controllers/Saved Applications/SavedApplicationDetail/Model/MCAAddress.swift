//
//  MCAAddress.swift
//  MCAProtect
//
//  Created by User on 03/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAAddress: NSObject {

    var billingAddressId        : Int!
    var billingCity             : String!
    var billingContactNumber    : Int!
    var billingState            : MCABillingState!
    var billingStreetAddress    : String!
    var billingZipcode          : String!
    var businessAddressId       : Int!
    var businessCity            : String!
    var businessContactNumber   : Int!
    var businessFaxNumber       : Int!
    var businessState           : MCABillingState!
    var businessStreetAddress   : String!
    var businessZipcode         : String!
    var sameBillingAddress      : Bool!
    var webAddress              : String!
    
    init(address: JSON!) {
        
        if address.isEmpty {
            
            return
        }
        
        billingAddressId        = address["billing_address_id"].intValue
        billingCity             = address["billing_city"].stringValue
        billingContactNumber    = address["billing_contact_number"].intValue
        let billingStateJson    = address["billing_state"]
        if !billingStateJson.isEmpty {
            billingState = MCABillingState(billingState: billingStateJson)
        }
        billingStreetAddress    = address["billing_street_address"].stringValue
        billingZipcode          = address["billing_zipcode"].stringValue
        businessAddressId       = address["business_address_id"].intValue
        businessCity            = address["business_city"].stringValue
        businessContactNumber   = address["business_contact_number"].intValue
        businessFaxNumber       = address["business_fax_number"].intValue
        let businessStateJson   = address["business_state"]
        if !businessStateJson.isEmpty {
            businessState = MCABillingState(billingState: businessStateJson)
        }
        businessStreetAddress   = address["business_street_address"].stringValue
        businessZipcode         = address["business_zipcode"].stringValue
        sameBillingAddress      = address["same_billing_address"].boolValue
        webAddress              = address["web_address"].stringValue
    }
}
