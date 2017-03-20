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
    
    func setCommonRate()
    
}

class MCAFundingProgramDetailCell: UITableViewCell {

    var delegate : MatchedFundingProgramDetailCellDelegate?
   @IBOutlet weak var  commonRateButton : UIButton!
    

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
        self.delegate?.setCommonRate()
        
    }

}
