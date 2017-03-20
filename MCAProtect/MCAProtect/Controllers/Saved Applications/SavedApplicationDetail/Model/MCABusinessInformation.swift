//
//  MCABusinessInformation.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/20/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABusinessInformation: NSObject {
    
    var legalBusinessName : String?
    var contactName : String?
    var contactNumber : String?
    var email : String?
    var federalTaxId : String?
    var grossAnnualSales : Int?
    var businessEntityTypeId : Int?
    var dbaBusinessName : String?
    var incorporationCountryStateId : Int?
    var businessStartDate : String?
    var industryTypeId : Int?
    var businessSeasonal : Bool?
    
    init(data : NSDictionary?) {
        if nil == data {
            
        }
        else {
            
        }
    }

}
