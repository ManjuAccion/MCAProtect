//
//  MCALiensPaymentsTVCell.swift
//  MCAProtect
//
//  Created by Accion Labs on 01/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCALiensPaymentsTVCell: UITableViewCell {

    @IBOutlet weak var liensViewBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var liensViewHeightConstaint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func  cellDatasource ()  {
        liensViewBottomConstraints.constant = 0.0
    }
    
}
