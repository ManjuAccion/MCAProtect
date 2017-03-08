//
//  MatchedFPListTVCell.swift
//  MCAProtect
//
//  Created by Accion Labs on 08/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMatchedFPListTVCell: UITableViewCell {
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var checkButton : UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkButton.setImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
        checkButton.isSelected = false;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
    @IBAction func checkButtonTapped (_ : Any)
    {
        if (checkButton.isSelected == true)
        {
            checkButton.setImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
            checkButton.isSelected = false;
        }
        else
        {
            checkButton.setImage(UIImage(named: "icon_checked"), for: UIControlState.normal)
            
            checkButton.isSelected = true;
        }
 
        
    }
    
}
