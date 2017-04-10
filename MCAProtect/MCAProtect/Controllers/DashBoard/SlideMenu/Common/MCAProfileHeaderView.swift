//
//  MCAProfileHeaderView.swift
//  MCAProtect
//
//  Created by Accion Labs on 31/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SDWebImage

class MCAProfileHeaderView: UIView {
    @IBOutlet weak var avatarImageView : UIImageView!
    @IBOutlet weak var profileNameLabel : UILabel!

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        self.avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        self.avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.clipsToBounds = true

    }

    
    func setPrfileDetails(mcapUser: MCAUser)
    {
        profileNameLabel.text = mcapUser.brokerContactName;
        
//        self.avatarImageView.sd_setImage(with: URL(string: mcapUser.brokerImageUrl))
    }
    
}
