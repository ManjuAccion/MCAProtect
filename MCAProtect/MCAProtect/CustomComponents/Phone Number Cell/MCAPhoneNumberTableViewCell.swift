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

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func phoneNumberButtonTapped(_ sender: Any) {
        
        delegate.callButtonTapped();
        
    }

}
