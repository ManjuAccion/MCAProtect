//
//  MCAFPListTableViewCell.swift
//  MCAProtect
//
//  Created by Accion Labs on 20/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAFPListTableViewCell: UITableViewCell {

    @IBOutlet weak var fundingProgramName : UILabel!
    @IBOutlet weak var loanTypeLabel : UILabel!
    @IBOutlet weak var termLabel : UILabel!
    @IBOutlet weak var amountRangeLabel : UILabel!
    @IBOutlet weak var contactNameLabel : UILabel!
    @IBOutlet weak var buyRateLabel : UILabel!

    @IBOutlet weak var selectedView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func dataSource(data: MCAFundingProgram)
    {
        fundingProgramName.text = data.fundingProgramName
        amountRangeLabel.text = MCAUtilities.currencyFormatter(inputItem: data.minimumLoan as AnyObject) + " - " + MCAUtilities.currencyFormatter(inputItem: data.maximumLoan as AnyObject)
        contactNameLabel.text = data.contactName
        termLabel.text = MCAUtilities.getMonthFromDate(days: data.term!)
        loanTypeLabel.text = data.loanType
        buyRateLabel.text = data.buyRate! + " %"
        if data.isSelected == true
        {
            self.selectedView.isHidden = false
            self.backgroundColor = ColorConstants.selectedBackground
        }
        else
        {
            self.selectedView.isHidden = true
            self.backgroundColor = ColorConstants.background
            
        }
        
    }

    
}
