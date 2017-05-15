//
//  MCABrokersListTVCell.swift
//  MCAProtect
//
//  Created by Sarath Neeravallil on 11/05/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABrokersListTVCell: UITableViewCell {

    @IBOutlet weak var leftSelectionView: UIView!
    @IBOutlet weak var brokerNameLabel: UILabel!
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var applicationCountLabel: UILabel!
    @IBOutlet weak var applicationStatusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func applicationStatus(_ sender: Any) {
        
    }
    
    @IBAction func phoneNumberButonTapped(_ sender: Any) {
        
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        
    
    }
    
    func setBrokerList(brokerList: MCABrokerList) {
        
        brokerNameLabel.text    = brokerList.contactName
        emailButton.setTitle(brokerList.email, for:.normal)
        phoneNumberButton.setTitle(brokerList.contactNumber.toUSPhoneNumberFormat(), for: .normal)
        applicationCountLabel.text = "\(brokerList.applicationsCount!)"
        
        if brokerList.active == true {
            applicationStatusButton.setImage(UIImage(named: "iconSwitchOn"), for: .normal)
        }
        else {
            applicationStatusButton.setImage(UIImage(named: "iconSwitchOff"), for: .normal)
        }
    }
    
}
