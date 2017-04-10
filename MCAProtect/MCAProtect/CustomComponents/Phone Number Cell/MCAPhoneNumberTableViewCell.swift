//
//  MCAPhoneNumberTableViewCell.swift
//  MCAProtect
//
//  Created by Accion Labs on 15/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAPhoneNumberTableViewCell: UITableViewCell {
    
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var titleLabel : UILabel!
    
    var delegate : MCABaseViewController!
    var phoneNumber : String!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func phoneNumberButtonTapped(_ sender: Any) {
        
        delegate.callButtonTapped(phoneNumber: phoneNumber)
    }
    
    func setMerchantApplicationSummary(merchantSummary : MCAMerchantApplicationDetail, merchantSummaryKey : MASummaryKeys) {
        titleLabel.text = merchantSummaryKey.rawValue
        phoneNumberButton.setTitle(merchantSummary.getValueFromKey(merchantSummaryKey: merchantSummaryKey), for: .normal)
        phoneNumber = merchantSummary.getValueFromKey(merchantSummaryKey: merchantSummaryKey)
    }
    
    func setBusinessInformation(businessInformation : MCABusinessInformation, businessInfoKey : BusinessInformationKeys) {
        titleLabel.text = businessInfoKey.rawValue
        phoneNumberButton.setTitle(businessInformation.getValueFromKey(key: businessInfoKey), for: .normal)
        phoneNumber = businessInformation.getValueFromKey(key: businessInfoKey)
    }
    
    func setBusinessAddress(businessAddress : MCAAddress, businessAddressKey : BusinessAddressKeys) {
        titleLabel.text = businessAddressKey.rawValue
        phoneNumberButton.setTitle(businessAddress.getValueFromKey(key: businessAddressKey), for: .normal)
        phoneNumber = businessAddress.getValueFromKey(key: businessAddressKey)
    }
}
