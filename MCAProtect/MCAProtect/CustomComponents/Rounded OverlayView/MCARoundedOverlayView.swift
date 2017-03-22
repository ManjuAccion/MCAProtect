//
//  MCARoundedOverlayView.swift
//  MCAProtect
//
//  Created by Manjunath on 16/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCARoundedOverlayView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    override func awakeFromNib() {
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = ColorConstants.btnBgColor.cgColor;

    }
    
}
