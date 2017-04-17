//
//  MCASubmitStipulationsCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/8/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON
class MCASubmitStipulationsCell: UITableViewCell {
    
    
    @IBOutlet weak var merchantNameLabel: UILabel!
    @IBOutlet weak var documentTypeLabel: UILabel!
    @IBOutlet weak var documentFileNameLabel: UILabel!
    @IBOutlet weak var viewApplicationButton: UIButton!
    @IBOutlet weak var downloadApplicationButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func viewApplicationButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func downloadApplicationTapped(_ sender: Any) {
        
    }
    
    func setSubmitStipulationsCell(documentDetail: JSON!) {
        
        self.merchantNameLabel.text = documentDetail["document_name"].stringValue
        
        self.documentTypeLabel.text = "Created at: \(MCAUtilities.getFormmattedDate(dateString: documentDetail["created_at"].stringValue))"
        
    }
    
    
    
}
