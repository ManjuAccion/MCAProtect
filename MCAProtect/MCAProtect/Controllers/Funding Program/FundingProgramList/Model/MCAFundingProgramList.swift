//
//  MCAFundingProgramList.swift
//  MCAProtect
//
//  Created by Accion Labs on 23/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFundingProgramList: NSObject {
    
    var fundingProgramName : String!
    var contactName : String!
    var term : String!
    var timeInBuisness : String!
    var buyRate : String!
    var creditScore : String!
    var minimumLoan : String!
    var maximumLoan : String!
    var email : String!
    var phoneNumber : String!

    
    init(Data : NSDictionary?) {
        
        if Data != nil {
            
        }
        else
        {
            
            fundingProgramName = "Stacy's Botique"
            contactName = "Syndicate Premium"
            term = "18 months"
            timeInBuisness = "6 months"
            buyRate = "1.28%"
            creditScore = "650"
            minimumLoan = "$2000"
            maximumLoan = "$10,000"
            email = "halen@gmail.com"
            phoneNumber = "+(44)7432345678"
        }
    }

}
