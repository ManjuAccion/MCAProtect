//
//  MCASavedApplicationsBankRecordsTVCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/28/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASavedApplicationsBankRecordsTVCell: UITableViewCell {
    
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var accountNumberTextLabel: UILabel!
    @IBOutlet weak var avgDailyBalanceTextLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
