//
//  MCAAskFunderApplicationListTVCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAAskFunderApplicationListTVCell: UITableViewCell {
    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var iconCheckedImageView: UIImageView!
    @IBOutlet weak var chatButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func chatButtonTapped(_ sender: Any) {
        
    }
}
