//
//  MCAConstants.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

struct ColorConstants {
    
    
    
    static let newbgColor                  = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#A02336")

    static let red                  = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#A32A2A")
    static let newRed                  = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#AD2B37")

    
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

    
    static let btnBgColor           = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#A32A2A")
    static let btnborderColor           = MCAUtilities.hexStringToUIColor(hexaDecimalString:"#8C8C8C")
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
    static let MCAPhoneNumberTableViewCell           = "MCAPhoneNumberTableViewCell"
    static let MCAEmailTableViewCell                 = "MCAEmailTableViewCell"
    static let MCANewChatTVCell                      = "MCANewChatTVCell"
    static let MCAAskFunderCommunicationTVCell       = "MCAAskFunderCommunicationTVCell"
    static let MCADealsPipelineTVCell                = "MCADealsPipelineTVCell"

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
    static let MCAAskFunderApplicationListVC                          = "MCAAskFunderApplicationListVC"
    static let MCAAskFunderApplicationSummaryVC                     = "MCAAskFunderApplicationSummaryVC"
    static let MCAAskFunderChatDetailVC                             = "MCAAskFunderChatDetailVC"
    static let MCAAskFunderChatDashboardVC                          = "MCAAskFunderChatDashboardVC"
    static let MCAMatchedFundingProgramVC                           = "MCAMatchedFundingProgramVC"
    static let MCAAskFunderNewChatVC                                = "MCAAskFunderNewChatVC"

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
    
    case New                = 1
    case UnderWriting       = 2
    case NeedMoreStips      = 3
    case Funded             = 4
    case DNQ                = 5
    case Lost               = 6
    case Renewal            = 7
}

enum ApplicationStatus : Int {
    case ResumeApplication  = 1
    case CopyApplication    = 2
}

enum ApplicationSummaryKeys: String {

    case SASummarySubmittedOn   = "Submitted On"
    case SASummaryBusinessName  = "Business Name"
    case SASummaryNeedeIn       = "Needed In"
    case SASummaryLoanValue     = "Loan Value"
}

enum FPApplicationSummaryKeys : String {
    
    case FPSummaryFundingProgram = "Funding Program"
    case FPSummaryContact = "Contact"
    case FPSummaryTerm = "Term"
    case FPSummaryTimeInBuisness = "Time in Buisness"
    case FPSummaryBuyRate = "Buy Rate"
    case FPSummaryCreditScore = "Credit Score"
    case FPSummaryMinimumLoan = "Minimum Loan"
    case FPSUmmaryMaximumLoan = "Maximum Loan"
}

enum FPProgramInformationKeys : String
{
    
    case FPProgramInformation = "Program Information"
    case FPMaxTerm =  "Max Term"
    case FPMinimumLoanAmount = "Minimum Loan Amount"
    case FPMaximumLoanAmount = "Maximum Loan Amount"
    case FPBuyRate = "Buy rate"
    case FPMaxUPSellRate = "Max Up Sell Rate"
    case FPMaxGrossRevenue = "Max % of Gross Revenue"
    case FPOriginationFee = "Origination Fee"
    case FPLoanType = "Loan Type"
    case FPInstallmentType = "Installment Type"
    case FPAcceptLoanPosition = "Accept Loan Position"
    case FPLoanAgreement = "Loan Agreement False"
    
    
}

enum FPMerchantRequirementkeys : String{
    
    case FPMinimumCreditScore = "Minimum Credit Score"
    case FPMinimumTimeInBusiness = "Minimum Time in Business"
    case FPMinimumMonthlySales = "Minimum Monthly Sales"
    case FPMinimumNumOfBankDeposits = "Minimum Number of Bank Deposits(Avg)"
    case FPDaysWithNegativeBalance =  "Days with Negative Balance"
    case FPMinimumDepositeAmount = "Minimum Deposit Amount(Avg)"
    case FPMinimumDailyBalance = "Minimum Daily Balance(Avg)"
}

enum FPLiensAndBankruptcyKeys : String{
    
    case FPJudegementsORLiens = "Judgements/Liens Allowed"
    case FPNumberOfJudementsOrLiens = "Number of Judgements/Liens Allowed"
    case FPMaxLiensOrJudgementAmount = "Max Liens/Judgements Amount"
    case FPIsBankruptcyAllowed = "Is Bankruptcy Allowed?"
    case FPPaymentPlan  = "Can Merchant be in Payment Plan"
    case FPMontlyPaymentAllowed = "Allowed Montly Payment"
    case FPMerchantSatisfiedBankruptcy = "Has Merchant Satisfied Bankruptcy?"
    case FPDischargedBankruptcy = "When Discharged from Bankruptcy?"
    
}
enum LoanDetailKeys : String {
    
    case businessName    = "Business Name"
    case creditScore      = "Credit Score"
    case loanAmount      = "Loan Amount"
    case loanTerm        = "Loan Term"
    case needItBy        = "Need it By"
}

enum BusinessInformationKeys : String {
    
    case legalBusinessName  = "Legal Business Name"
    case contactName        = "Contact Name"
    case telephone          = "Telephone"
    case email              = "Email"
    case federalTaxID       = "Federal Tax ID"
    case grossAnnualSales   = "Gross Annual Sales"
    case businessEntityType = "Business Entity Type"
    case dBABusinessName    = "DBA Business Name"
    case stateOfIncorprataion = "State of Incorporation"
    case businessStartDate  = "Business Start Date"
    case industryType       = "Industry Type"
    case seasonalBusiness   = "Seasonal Business"
}

enum BusinessAddressKeys : String {
    
    case street     = "Street"
    case city       = "City"
    case state      = "State"
    case zipCode    = "Zip Code"
    case webAddress = "Web Address"
    case telephone  = "Telephone"
    case faxNumber  = "Fax Number"
}

enum BankDetailKeys : String {
    
    case accountNumber              = "Account Number"
    case range                      = "Range"
    case statementPeriod            = "Statement Period"
    case numberOfDeposits           = "Number of Deposits"
    case depositAmount              = "Deposit Amount"
    case daysWithNegativeBalance    = "Days with Negative Balance"
    case avgDailyBalance            = "Average Daily Balance"
}

enum MCALoanDetailKeys : String {
    case company            = "Company"
    case fundedAmount       = "Funded Amount"
    case currentBalance     = "Current Balance"
    case loanTerms          = "Loan Terms"
    case frequency          = "Frequency"
    case amount             = "Amount"
}

enum OwnerInformationDetailKeys : String {
    
    case name                   = "Name"
    case socialSecurityNumber   = "Social Security Number (SSN)"
    case dob                    = "DOB"
    case streetAddress          = "Street Address"
    case city                   = "City"
    case state                  = "State"
    case zipCode                = "Zip Code"
    case homePhone              = "Home Phone"
    case percentOwned           = "% Owned"
}

enum BusinessLocationDetailKeys : String {
    case locationType       = "Location Type"
    case monthlyPayement    = "Monthly Payement"
    case streetAddress      = "Street Address"
    case city               = "City"
    case state              = "State"
    case zipCode            = "Zip Code"
}

enum MerchantDocumentationKeys : String {
    case proofOfIdentity    = "Proof of Identity"
    case proofOfResidence   = "Proof of Residence"
}

enum MASummaryKeys : String {
    case businessName   = "Business Name"
    case contactName    = "Contact Name"
    case loanAmount     = "Loan Amount"
    case email          = "Email"
    case telephone      = "Telephone"
    case offeredOn      = "Offered on"
}

enum rightMenuItems : NSInteger {
    case Notification = 0
    case PersonalisedSettings = 1
    case AboutUs = 2
    case TermsOfUse = 3
    case PrivacyPolicy = 4
    case ShareFeedback = 5
    case ShareApp = 6
    case RateUs = 7
}

enum leftMenuItems : NSInteger {
    case Dashboard = 0
    case SavedApplications = 1
    case FundingPrograms = 2
    case AskFunder = 3
}


struct MCAAPIEndPoints {
    
    static let BrokerLoginAPIEndPoint               = "/broker/sign_in.json"
    static let BrokerLogoutAPIEndPoint               = "/broker/sign_out.json"
    static let BrokerForgotPasswordAPIEndPoint       = "/broker/password.json"
    static let BrokerDashBoardAPIEndpoint            = "/brokers/overall_daterange_wise_application_status/"
    static let BrokerApplicationSummaryAPIEndpoint      = "/brokers/get_state_wise_applications"

    
    static let BrokerUpdateProfileAPIEndpoint               = "/broker"
    static let BrokerageRegistrationAPIEndPoint               = "/brokerage_firm.json"
    static let BrokerageLoginAPIEndPoint                      = "/brokerage_firm/sign_in.json"
    static let BrokerageLogoutAPIEndPoint                     = "/brokerage_firm/sign_out.json"
    static let BrokerageForgotPasswordAPIEndPoint               = "/brokerage_firm/password.json"
    static let BrokerageUpdateProfileAPIEndpoint               = "/brokerage_firm.json"

}




