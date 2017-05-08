//
//  MCANotificationTableViewCell.swift
//  MCAProtect
//
//  Created by Accion Labs on 08/05/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCANotificationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dataLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var dotImageView : UIImageView!


    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
