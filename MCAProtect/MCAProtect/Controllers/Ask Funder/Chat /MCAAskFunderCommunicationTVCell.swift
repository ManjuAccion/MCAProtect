//
//  MCAAskFunderCommunicationTVCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/15/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAAskFunderCommunicationTVCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var profileImgeView : UIImageView!
    @IBOutlet weak var messageLabel : UILabel!
    @IBOutlet weak var selectedView : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImgeView.layer.cornerRadius = 0.5 * profileImgeView.bounds.size.width
        profileImgeView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
