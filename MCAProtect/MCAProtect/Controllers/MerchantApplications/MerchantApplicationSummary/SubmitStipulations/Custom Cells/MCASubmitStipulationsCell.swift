//
//  MCASubmitStipulationsCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/8/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol MCASubmitStipulationsCellDelegate {
    func viewApplication(docUrl : URL)
}

class MCASubmitStipulationsCell: UITableViewCell {
    
    
    @IBOutlet weak var merchantNameLabel: UILabel!
    @IBOutlet weak var documentTypeLabel: UILabel!
    @IBOutlet weak var documentFileNameLabel: UILabel!
    @IBOutlet weak var viewApplicationButton: UIButton!
    @IBOutlet weak var downloadApplicationButton: UIButton!
    
    var delegate:MCASubmitStipulationsCellDelegate?

    var docUrl : String!
    var docRef : CGPDFDocument!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func viewApplicationButtonTapped(_ sender: Any) {
        let docUrl = URL.init(string: self.docUrl)
        delegate?.viewApplication(docUrl: docUrl!)
    }
    
    @IBAction func downloadApplicationTapped(_ sender: Any) {
        
    }
    
    func setSubmitStipulationsCell(documentDetail: JSON!) {
        
        self.merchantNameLabel.text = documentDetail["document_name"].stringValue
        self.docUrl = documentDetail["document"]["doc_url"].stringValue
        self.documentTypeLabel.text = "Created at: \(MCAUtilities.getFormmattedDate(dateString: documentDetail["created_at"].stringValue))"
        
    }
    
    
    
}
