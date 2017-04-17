//
//  MCABusinessTypeTableViewCell.swift
//  MCAProtect
//
//  Created by Accion Labs on 17/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABusinessTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var sicLabel : UILabel!
    @IBOutlet weak var typeNameLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
