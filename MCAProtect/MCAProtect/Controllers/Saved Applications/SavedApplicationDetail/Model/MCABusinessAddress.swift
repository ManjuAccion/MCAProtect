//
//  MCABusinessAddress.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/20/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABusinessAddress: NSObject {
    
    var street : String!
    var city : String!
    var state : String!
    var zipCode : String!
    var webAddress : String!
    var telephone : String!
    var faxNumber : String!
    var fieldCount : Int!

    init(data : NSDictionary?) {
        if nil == data {
            street = "E 76th PI"
            city = "Los Angeles"
            state = "California"
            zipCode = "780098"
            webAddress = "www.staxy.com"
            telephone = "(987) 876-8766"
            faxNumber = "(987) 876-8766"
            fieldCount = 7
        }
        else {
            
        }
    }

    
    init(loanApplication : MCALoanApplication) {
        
            street = loanApplication.address.businessStreetAddress
            city = loanApplication.address.businessCity
            state = loanApplication.address.businessState.stateName
            zipCode = loanApplication.address.businessZipcode
            webAddress = loanApplication.address.webAddress
            telephone = loanApplication.ownersInfo.last?.homeTelephone
            faxNumber = "\(loanApplication.address.businessFaxNumber!)"
            fieldCount = 7
    }
    
    func getValueFromKey(key:BusinessAddressKeys) -> String {
        
        var modelValue : String!
        
        switch key {
            
        case .street :
            modelValue = street
            
        case .city :
            modelValue = city
            
        case .state :
            modelValue = state
            
        case .zipCode :
            modelValue = zipCode
            
        case .webAddress :
            modelValue = webAddress
            
        case .telephone :
            modelValue = "\(telephone!)"
            
        case .faxNumber :
            modelValue = "\(faxNumber!)"
            
        }
        
        return modelValue
    }

}
