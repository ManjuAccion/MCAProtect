//
//  MCASavedApplicationsListTVCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/22/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASavedApplicationsListTVCell: UITableViewCell {

    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var applicationNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var merchantNameLabel: UILabel!
    
    var delegate : MCABaseViewController!
    var phoneNumber : String!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        delegate.emailButtonTapped(emailString: (emailButton.titleLabel?.text)!)
    }
    
    @IBAction func phoneNumberButtonTapped(_ sender: Any) {
        
        delegate.callButtonTapped(phoneNumber: phoneNumber);
    }
    
    func setSavedApplicationList(savedApplicationData:MCASavedApplication) {
        
        applicationNameLabel.text = savedApplicationData.applicationName
        amountLabel.text = MCAUtilities.currencyFormatter(inputItem: savedApplicationData.amount as AnyObject)
        
        let dateValue = MCAUtilities.getDateFromString(dateString: savedApplicationData.submittedOn)
        daysLabel.text = MCAUtilities.daysBetweenDate(startDate: dateValue, endDate: NSDate() as Date)
        emailButton.setTitle(savedApplicationData.merchantEmail, for: .normal)
        phoneNumberButton.setTitle(savedApplicationData.merchantPhoneNumber.toUSPhoneNumberFormat(), for: .normal)
        merchantNameLabel.text = savedApplicationData.merchantName
        phoneNumber = savedApplicationData.merchantPhoneNumber
        
        
            if savedApplicationData.isSelected == true
            {
                self.selectedView.isHidden = false
                self.backgroundColor = ColorConstants.selectedBackground
            }
            else
            {
                self.selectedView.isHidden = true
                self.backgroundColor = ColorConstants.background
            
            }
    }
    


}
