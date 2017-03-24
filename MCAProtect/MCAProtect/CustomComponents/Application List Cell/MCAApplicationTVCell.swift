//
//  MCAApplicationTVCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit



class MCAApplicationTVCell: UITableViewCell {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phoneNumberButton: UIButton!



    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var rightButton: UIButton!
    var delegate : MCABaseViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func dataSource(data: MCAFundingProgramList)
    {
       headingLabel.text = data.fundingProgramName
        detailLabel.text = MCAUtilities.currencyFormatter(inputItem: data.minimumLoan as AnyObject)

        contactNameLabel.text = data.contactName
        emailButton.setTitle(data.email, for: UIControlState.normal)
        phoneNumberButton.setTitle(data.phoneNumber, for: UIControlState.normal)
        

        
    }

    @IBAction func emailButtonTapped(_ sender: Any) {
      delegate.emailButtonTapped()
    }
    
    @IBAction func phoneNumberButtonTapped(_ sender: Any) {
        
        delegate.callButtonTapped();
        
            }
}
