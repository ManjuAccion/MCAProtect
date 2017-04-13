//
//  MCABankDetailsTVCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/1/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCABankDetailsTVCell: UITableViewCell {

    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var dataTF: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
    }
    
    func setBankDetail(bankDetail : MCABankRecords, mcaLoanKey : BankDetailKeys)
    {
        headingLabel.text = mcaLoanKey.rawValue
        dataTF.text =  bankDetail.getValueFromKey(key: mcaLoanKey)
    }
    
    
    
}
