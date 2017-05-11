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
    @IBOutlet weak var phoneNumberLabel: UIButton!
    @IBOutlet weak var emailLabel: UIButton!
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
    
}
