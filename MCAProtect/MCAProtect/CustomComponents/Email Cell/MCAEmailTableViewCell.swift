//
//  MCAEmailTableViewCell.swift
//  MCAProtect
//
//  Created by Accion Labs on 15/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAEmailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var titleLabel : UILabel!
    
    var delegate : MCABaseViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        delegate.emailButtonTapped(emailString: (emailButton.titleLabel?.text)!)
    }
    
    func setMerchantApplicationSummary(merchantSummary : MCAMerchantApplicationDetail, merchantSummaryKey : MASummaryKeys) {
        titleLabel.text = merchantSummaryKey.rawValue
        emailButton.setTitle(merchantSummary.getValueFromKey(merchantSummaryKey: merchantSummaryKey), for: .normal)
    }
    
    func setBusinessInformation(businessInformation : MCABusinessInformation, businessInfoKey : BusinessInformationKeys) {
        titleLabel.text = businessInfoKey.rawValue
        emailButton.setTitle(businessInformation.getValueFromKey(key: businessInfoKey), for: .normal)
    }
}
