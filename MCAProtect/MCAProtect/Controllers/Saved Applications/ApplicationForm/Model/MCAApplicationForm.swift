//
//  MCAApplicationForm.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAApplicationForm: NSObject {
    
    var formDataSource = [String]()
    
    override init() {
        
        formDataSource = ["Loan Details","Business Information", "Business Address", "Liens/Payments/Bankruptcy", "Merchant Documentation", "Bank Records","MCA Loans","Owner/Officer Information","Business Location"]
    }

}
