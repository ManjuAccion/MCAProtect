//
//  MCASubmitStipulationsView.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/9/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASubmitStipulationsView: UIView {
    
    @IBOutlet weak var addMoreDocumentsButton: UIButton!

    init() {
        super.init(frame: UIScreen.main.bounds)
        
        addMoreDocumentsButton.layer.cornerRadius = 3.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
