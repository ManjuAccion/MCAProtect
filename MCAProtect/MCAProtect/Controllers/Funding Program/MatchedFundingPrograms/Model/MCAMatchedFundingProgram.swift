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
    var  showDetails : Bool?
    var  isSelected : Bool?
    var  funderName : NSString?
    var  term :  NSString?
    var  loanRange : NSString?
    var  buyRate : NSString?
    var  maxUpsellRate : NSString?
    var  upsellRate : NSString?
    var  totalRate : NSString?


    
    init(data : NSDictionary?) {
        
        if data != nil {
            
        }
        else
        {
            funderName = "Greenbox Capital"
            term = "10 Months"
            loanRange = "$10000 to $100000"
            buyRate = "1.5"
            maxUpsellRate = "1.55"
            upsellRate = "Rate"
            totalRate = "10.0"
            isSelected = false
            showDetails = false
        }
        
    }
}





