//
//  MCAApplicationTVCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

protocol MCAApplicationTVCellDelegate {
    
    func rightActionButtonTapped(_ sender : UIButton)
}

class MCAApplicationTVCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var rightButton: UIButton!
    
    var delegate : MCABaseViewController!
    var applicationTVDelegate :MCAApplicationTVCellDelegate?

    var phoneNumber : String!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func rightButtonTapped(_ sender: Any) {
        applicationTVDelegate?.rightActionButtonTapped(sender as! UIButton)
    }

    @IBAction func emailButtonTapped(_ sender: Any) {
      delegate.emailButtonTapped(emailString: (emailButton.titleLabel?.text)!)
    }
    
    @IBAction func phoneNumberButtonTapped(_ sender: Any) {
        delegate.callButtonTapped(phoneNumber: phoneNumber);
    }
    
    func dataSource(data: MCAFundingProgram)
    {
        nameLabel.text = data.fundingProgramName
        amountLabel.text = MCAUtilities.currencyFormatter(inputItem: data.minimumLoan as AnyObject)
        contactNameLabel.text = data.contactName
        emailButton.setTitle(data.email, for: UIControlState.normal)
        phoneNumberButton.setTitle(data.phoneNumber, for: UIControlState.normal)
        phoneNumber = data.phoneNumber
        
        if data.isSelected == true
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
    
    func setMerchantApplicationList(merchantApplicationList: MCAMerchantApplicationDetail) {
        
        nameLabel.text = merchantApplicationList.businessName
        amountLabel.text = MCAUtilities.currencyFormatter(inputItem: merchantApplicationList.loanAmount as AnyObject)
        emailButton.setTitle(merchantApplicationList.merchantEmail, for: UIControlState.normal)
        phoneNumberButton.setTitle(merchantApplicationList.contactNumber.toUSPhoneNumberFormat(), for: UIControlState.normal)
        contactNameLabel.text = merchantApplicationList.contactName
        phoneNumber = merchantApplicationList.contactNumber
    }
}
