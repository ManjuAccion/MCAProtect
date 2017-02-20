//
//  MCAApplicationTVCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAApplicationTVCell: UITableViewCell {
    
    @IBOutlet weak var merchantName: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var viewDetailsButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func viewDetailsButtonTapped(_ sender: Any) {
        
    }
}
