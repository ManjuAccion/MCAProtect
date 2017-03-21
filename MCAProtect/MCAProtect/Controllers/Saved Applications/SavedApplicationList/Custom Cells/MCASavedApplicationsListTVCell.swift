//
//  MCASavedApplicationsListTVCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/22/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class MCASavedApplicationsListTVCell: UITableViewCell {

   
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
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


}
