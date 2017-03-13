//
//  MCAMatchedFundingProgram.swift
//  MCAProtect
//
//  Created by Accion Labs on 10/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMatchedFundingProgram: NSObject
{
    var  isSelected : Bool?
    var  businessName : NSString?
    var  loanTerm :  NSString?
    var  loanAmount : NSString?
    var  setCommonRate : NSString?
     
    init(data : NSDictionary?) {
        
        if data != nil {
            
        }
        else
        {
            businessName = "Stacy Botique"
            loanTerm = "10 Months"
            loanAmount = "$1000"
            isSelected = false
        }
        
    }
}





