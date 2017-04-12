//
//  MCALoansTVCell.swift
//  MCAProtect
//
//  Created by Accion Labs on 02/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCALoansTVCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setMCALoanApplication(mcaLoanApplication :MCALoanAccountsList) {
        
        titleLabel.text     = mcaLoanApplication.companyName
        amountLabel.text  = MCAUtilities.currencyFormatter(inputItem: mcaLoanApplication.fundedAmount! as AnyObject)
    }
}
