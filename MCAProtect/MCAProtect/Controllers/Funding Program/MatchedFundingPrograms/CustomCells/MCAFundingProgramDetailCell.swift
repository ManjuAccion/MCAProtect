//
//  MCAFundingProgramDetailCell.swift
//  MCAProtect
//
//  Created by Manjunath on 16/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

protocol MatchedFundingProgramDetailCellDelegate
{
    
    func setCommonRate(object: AnyObject)
    
}

class MCAFundingProgramDetailCell: UITableViewCell {

    var delegate : MatchedFundingProgramDetailCellDelegate?
   @IBOutlet weak var  commonRateButton : UIButton!
    @IBOutlet weak var businessNameLabel : UILabel!
    @IBOutlet weak var needItByLabel : UILabel!
    @IBOutlet weak var loanTermLabel : UILabel!
    @IBOutlet weak var loanAmountLabel : UILabel!


    
    
    var indexPath: NSIndexPath!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func commonRateBtnTapped()
    {
        self.delegate?.setCommonRate(object: indexPath)
        
    }
    
    func updateDataSource(merchantApplicationDetailObject : MCAMerchantApplicationDetail)  {
      businessNameLabel.text = merchantApplicationDetailObject.businessName
      needItByLabel.text = merchantApplicationDetailObject.loanRequirementTenure
      loanAmountLabel.text = MCAUtilities.currencyFormatter(inputItem: merchantApplicationDetailObject.loanAmount as AnyObject) as String!
        loanTermLabel.text = merchantApplicationDetailObject.loanTerm
        
    }

}
