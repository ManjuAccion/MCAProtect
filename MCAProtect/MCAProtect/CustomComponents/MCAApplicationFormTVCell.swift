//
//  MCAApplicationFormTVCell.swift
//  MCAProtect
//
//  Created by Accion Labs on 23/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAApplicationFormTVCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var selectedView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
