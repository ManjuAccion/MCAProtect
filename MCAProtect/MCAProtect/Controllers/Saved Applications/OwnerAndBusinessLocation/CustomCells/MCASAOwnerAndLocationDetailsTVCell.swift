//
//  MCAOwnerAndLocationDetailsTVCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/1/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASAOwnerAndLocationDetailsTVCell: UITableViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setOwnerInformation(ownerInformation:MCAOwnerInformation) {
        headingLabel.text = ownerInformation.ownerName
        detailLabel.text = ownerInformation.socialSecurityNumber
    }
    
    func setBusinessLocation(businessLocation:MCABusinessLocation) {
        headingLabel.text = businessLocation.businessLocation
        detailLabel.text = businessLocation.locationName
    }
    
}
