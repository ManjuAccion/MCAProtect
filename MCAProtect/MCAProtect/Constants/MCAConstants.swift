//
//  MCAConstants.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

struct ColorConstants {
    
    static let red                  = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#A32A2A")
    
    static let grey                 = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#4B4B4B")
    static let greyAlpha80          = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#6F6F6F")
    static let greyAlpha60          = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#939393")
    static let greyAlpha40          = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#B7B7B7")
    static let greyAlpha20          = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#DBDBDB")
    
    static let blue                 = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#2D3943")
    static let blueAlpha80          = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#576169")
    static let blueAlpha60          = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#81888E")
    static let blueAlpha40          = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#ABB0B4")
    static let blueAlpha20          = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#D5D7D9")

    static let green                = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#339966")
    
    static let selectedBackground   = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#F8F8F8")
    static let background           = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#F2F2F2")


    
}

struct CellIdentifiers {
    
    static let MCAApplicationStatusTVCell           = "MCAApplicationStatusTVCell"
    static let MCAApplicationFormTVCell             = "MCAApplicationFormTVCell"
    static let MCAApplicationTVCell                 = "MCAApplicationTVCell"
    static let MCASavedApplicationsListTVCell       = "MCASavedApplicationsListTVCell"
    static let MCAAskFunderApplicationListTVCell    = "MCAAskFunderApplicationListTVCell"

    static let MCAApplicationSummaryTVCell          = "MCAApplicationSummaryTVCell"
    static let MCAOwnerAndLocationDetailsTVCell     = "MCASAOwnerAndLocationDetailsTVCell"
    static let MCASavedApplicationsBankRecordsTVCell = "MCASavedApplicationsBankRecordsTVCell"
    static let MCASavedApplicationsBankDetailsTVCell = "MCASavedApplicationsBankDetailsTVCell"
    static let MCAApplicationListTVCell              = "MCAApplicationTVCell"
    static let MCASubmitStipulationsCell             = "MCASubmitStipulationsCell"
}

struct StoryboardName {
    
    static let MCASavedApplication                  = "SavedApplication"
    static let MCADashBoard                         = "DashBoard"
    static let MCALogin                             = "Login"
    static let MCAForgotPassword                    = "ForgotPassword"
    static let MCARegistration                      = "Registration"
    static let MCAWebView                           = "WebView"
    static let MCAmPin                              = "mPin"
    static let MCACommon                            = "Common"
    static let MCAProfileDetail                     = "ProfileDetail"
    static let MCAFundingProgram                    = "FundingProgram"
    static let MCAMerchantApplication               = "MerchantApplication"
    static let MCAMatchedFundingProgram             = "MatchedFundingProgram"
    static let MCAGenericPopUp                      = "GenericPopUp"
    static let MCAAskFunder                         = "AskFunder"
}

struct VCIdentifiers {
    static let MCASavedApplicationDetailVC                          = "MCASavedApplicationDetailVC"
    static let MCASavedApplicationMerchantDocumentationVC           = "MCASavedApplicationMerchantDocumentationVC"
    static let MCAApplicationSummaryVC                              = "MCAApplicationSummaryVC"
    static let MCAApplicationFormVC                                 = "MCAApplicationFormVC"
    static let MCASavedApplicationListVC                            = "MCASavedApplicationListVC"
    static let MCASALiensPaymentsVC                                 = "MCASALiensPaymentsVC"
    static let MCASAOwnerAndLocationDetailsVC                       = "MCASAOwnerAndLocationDetailsVC"
    static let MCASavedApplicationsBankRecordsVC                    = "MCASavedApplicationsBankRecordsVC"
    static let MCASavedApplicationBankDetailsVC                     = "MCASavedApplicationBankDetailsVC"
    static let MCASABusinessLocationDetails                         = "MCASABusinessLocationDetails"
    static let MCASAOwnerInformationDetailVC                        = "MCASAOwnerInformationDetailVC"
    static let MCASALoanDetailVC                                    = "MCASALoanDetailVC"
    static let MCAMerchantApplicationListVC                         = "MCAMerchantApplicationListVC"
    static let MCAMerchantApplicationSummaryVC                      = "MCAMerchantApplicationSummaryVC"
    static let MCAMASubmitStipulationsVC                            = "MCAMASubmitStipulationsVC"
    static let MCAAskFunderApplicationList                          = "MCAAskFunderApplicationList"


}


enum SavedApplicationForm : Int {
    
    case LoanDetails                    = 1
    case BusinessInformation            = 2
    case BusinessAddress                = 3
    case LiensOrPaymentsOrBankruptcy    = 4
    case MerchantDocumentation          = 5
    case BankRecords                    = 6
    case MCALoans                       = 7
    case OwnerOrOfficerInformation      = 8
    case BusinessLocation               = 9
}

enum ApplicationState :Int {
    
    case New                = 0
    case UnderWriting       = 1
    case NeedMoreStips      = 2
    case Funded             = 3
    case DNQ                = 4
    case Lost               = 5
    case Renewal            = 6
}

enum ApplicationStatus : Int {
    case ResumeApplication  = 1
    case CopyApplication    = 2
}






