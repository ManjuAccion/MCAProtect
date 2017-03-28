//
//  MCAFundingProgramApplicationForm.swift
//  MCAProtect
//
//  Created by Accion Labs on 23/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFundingProgramApplicationForm: NSObject
{
    
    var formDataSource = [String]()

    override init() {
        
        formDataSource =  ["Program Information", "Merchant Requirements", "Liens/Payments/Bankruptcy", "Additional Stipulations", "SIC Code & Business Types"]

    }
}
