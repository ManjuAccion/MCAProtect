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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        delegate.emailButtonTapped()
    }
    
    @IBAction func phoneNumberButtonTapped(_ sender: Any) {
        
        delegate.callButtonTapped();
    }
    
    func setSavedApplicationList(savedApplicationData:MCASavedApplicationList) {
        
        applicationNameLabel.text = savedApplicationData.applicationName
        amountLabel.text = MCAUtilities.currencyFormatter(inputItem: savedApplicationData.amount as AnyObject)
        daysLabel.text = "Need in \(savedApplicationData.neededIn!) Days"
        emailButton.setTitle(savedApplicationData.merchantEmail, for: .normal)
        phoneNumberButton.setTitle(savedApplicationData.merchantPhoneNumber, for: .normal)
        merchantNameLabel.text = savedApplicationData.merchantName
    }
    


}
