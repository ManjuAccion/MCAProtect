//
//  MCABusinessFinance.swift
//  MCAProtect
//
//  Created by Sarath N S on 03/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCABusinessFinance: NSObject {
    
    var bankRecords             : [MCABankRecords]!
    var businessLocations       : Bool!
    var businessLocationsList   : [MCABusinessLocationList]!
    var grossAnnualSales        : Int!
    var mcaLoanAccounts         : Bool!
    var mcaLoanAccountsList     : [MCALoanAccountsList]!
    var noOfBusinessLocations   : Int!
    var numberOfMcaLoanAccounts : AnyObject!
    var pastMcaLoan             : Bool!
    var revenueAmount           : Int!
    
    init(businessFinance: JSON!) {

        bankRecords = [MCABankRecords]()
        let bankRecordsArray            = businessFinance["bank_records"].arrayValue
        
        for bankRecordsJson in bankRecordsArray {
            let value = MCABankRecords(bankRecords: bankRecordsJson)
            bankRecords.append(value)
        }
        
        businessLocations               = businessFinance["business_locations"].boolValue
        businessLocationsList           = [MCABusinessLocationList]()
        let businessLocationsListArray  = businessFinance["business_locations_list"].arrayValue
        
        for businessLocationsListJson in businessLocationsListArray{
            let value = MCABusinessLocationList(businessLocationList: businessLocationsListJson)
            businessLocationsList.append(value)
        }
        grossAnnualSales                = businessFinance["gross_annual_sales"].intValue
        mcaLoanAccounts                 = businessFinance["mca_loan_accounts"].boolValue
        mcaLoanAccountsList             = [MCALoanAccountsList]()
        let mcaLoanAccountsListArray    = businessFinance["mca_loan_accounts_list"].arrayValue
        
        for mcaLoanAccountsListJson in mcaLoanAccountsListArray{
            let value = MCALoanAccountsList(loanAccountList: mcaLoanAccountsListJson)
            mcaLoanAccountsList.append(value)
        }
        
        noOfBusinessLocations           = businessFinance["no_of_business_locations"].intValue
        numberOfMcaLoanAccounts         = businessFinance["number_of_mca_loan_accounts"].stringValue as AnyObject
        pastMcaLoan                     = businessFinance["past_mca_loan"].boolValue
        revenueAmount                   = businessFinance["revenue_amount"].intValue
    }


}
