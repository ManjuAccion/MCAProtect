//
//  MCATableViewCell.swift
//  MCAProtect
//
//  Created by Accion Labs on 15/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCATableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView : UIImageView!
    @IBOutlet weak var cellLabel : UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
