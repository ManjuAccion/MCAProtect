//
//  MCAMerchantDocumentationTVCell.swift
//  MCAProtect
//
//  Created by Sarath Neeravallil on 05/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMerchantDocumentationTVCell: UITableViewCell {

    @IBOutlet weak var documentTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var viewDetailsButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewDetailsButton.setImage(UIImage(named: "iconDownload"), for: UIControlState.normal)
        viewDetailsButton.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func viewMerchantDocumentation(_ sender: Any) {
        
    }
    
    func setMerchantDocumentation(merchantDocumentation :MCAMerchantDocumentation) {
        
        documentTF.text     = merchantDocumentation.documentName
        descriptionTF.text  = merchantDocumentation.documentDescription
    }

}
