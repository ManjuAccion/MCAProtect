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
    
    func setBankRecords(bankRecords:MCABankRecords) {
        bankNameLabel.text = bankRecords.bankName
        accountNumberLabel.text = bankRecords.accountNumber
        amountLabel.text = MCAUtilities.currencyFormatter(inputItem: bankRecords.averageDailyBalance as AnyObject)
        
        //FIXME: - Do we need to move the bank name to center?
        if bankRecords.accountNumber.isEmpty {
            accountNumberTextLabel.isHidden = true
        }
        else {
            accountNumberTextLabel.isHidden = false
        }
    }
    
}
