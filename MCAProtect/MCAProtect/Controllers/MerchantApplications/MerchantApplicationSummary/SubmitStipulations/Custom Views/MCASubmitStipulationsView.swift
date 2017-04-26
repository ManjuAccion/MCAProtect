//
//  MCASubmitStipulationsView.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/9/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

protocol MCASubmitStipulationsViewDelegate {
    
    func addMoreDocuments()
}

class MCASubmitStipulationsView: UIView {
    
    @IBOutlet weak var addMoreDocumentsButton: UIButton!
    
    var delegate: MCASubmitStipulationsViewDelegate?

    override func awakeFromNib() {
        addMoreDocumentsButton.layer.cornerRadius = 3.0
    }

    init() {
        super.init(frame: UIScreen.main.bounds)
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func addMoreDocumentsTapped(_ sender: Any) {
        delegate?.addMoreDocuments()
    }

}
