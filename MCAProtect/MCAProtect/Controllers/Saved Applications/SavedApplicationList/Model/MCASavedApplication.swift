//
//  MCASavedApplicationList.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON



//{
//    "accepted_lending_program_id" = "<null>";
//    "avg_transaction_amount" = "<null>";
//    "bank_records_available" = 1;
//    bankruptcy = 0;
//    "bankruptcy_discharge_date" = "<null>";
//    "bankruptcy_monthly_payment" = 0;
//    "bankruptcy_monthly_payment_amount" = "<null>";
//    "bankruptcy_payment_plan" = 0;
//    "bankruptcy_satisfied" = 0;
//    "billing_address_id" = 1381;
//    "broker_id" = 67;
//    "business_address_id" = 1382;
//    "business_entity_type_id" = 2;
//    "business_locations" = 1;
//    "business_name" = Newapp;
//    "business_seasonal" = 0;
//    "business_start_date" = "2017-03-20T18:30:00.000Z";
//    "business_structure" = "<null>";
//    "contact_name" = "min tu";
//    "contact_number" = 2626262689;
//    "created_at" = "2017-03-28T07:58:08.586Z";
//    "credit_score" = "<null>";
//    "dba_business_name" = dbaleg;
//    "federal_tax_id" = 236265353;
//    "first_name" = min;
//    "gross_annual_sales" = 100;
//    id = 689;
//    "incorporation_country_state_id" = 2;
//    "industry_type_id" = 17;
//    "is_submit" = 0;
//    "judgements_or_liens" = 0;
//    "judgements_or_liens_amount" = 0;
//    "judgements_or_liens_no" = 0;
//    "last_name" = tu;
//    "legal_business_name" = Newleg;
//    "loan_amount" = 1000;
//    "loan_purpose" = new;
//    "loan_requirement_tenure" = "3 days";
//    "loan_term" = 2;
//    "mca_loan_accounts" = 0;
//    "merchant_credit_score_id" = "<null>";
//    "merchant_id" = 411;
//    "merchant_mail" = "mintu@streetwisemail.com";
//    "monthly_payment_amount" = 0;
//    "no_of_business_locations" = 1;
//    "number_of_mca_loan_accounts" = "<null>";
//    "past_mca_loan" = 0;
//    "payment_plan" = 0;
//    "peak_months" = "";
//    "previous_broker_id" = "<null>";
//    "request_merchant" = 0;
//    "revenue_amount" = 100;
//    "source_type" = MCAP;
//    "state_name" = "<null>";
//    "unique_token" = 669C8217533C7D1A15197606886E14CB;
//    "unix_timestamp" = "<null>";
//    "updated_at" = "2017-03-28T07:58:08.586Z";
//}


class MCASavedApplication: NSObject {
    
    var applicationName : String!
    var amount : Float!
    var merchantName : String!
    var merchantEmail : String!
    var merchantPhoneNumber : String!
    var neededIn : String!
    var brokerId : Int!
    var merchantId : Int!
    var id : Int!

    
    init(savedApplcation : JSON!) {
        applicationName = savedApplcation["business_name"].stringValue
        amount = savedApplcation["loan_amount"].floatValue
        merchantName = savedApplcation["contact_name"].stringValue
        merchantEmail = savedApplcation["merchant_mail"].stringValue
        merchantPhoneNumber = savedApplcation["contact_number"].stringValue
        brokerId = savedApplcation["broker_id"].intValue
        merchantId = savedApplcation["merchant_id"].intValue
        id = savedApplcation["id"].intValue
        neededIn = "Need in \(savedApplcation["loan_requirement_tenure"].stringValue)"
    }
}
