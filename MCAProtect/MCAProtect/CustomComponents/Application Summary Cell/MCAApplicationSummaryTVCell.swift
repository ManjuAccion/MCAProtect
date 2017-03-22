//
//  MCAApplicationSummaryTVCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

protocol MCAApplicationSummaryTVCellDelegate {
    
    func rightActionButtonTapped()
}


class MCAApplicationSummaryTVCell: UITableViewCell {
    
    
    @IBOutlet weak var dataTF: UITextField!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var viewDetailsButton: UIButton!
    
    var delegate:MCAApplicationSummaryTVCellDelegate?
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    
    func setDatasource(appSummary : MCAApplicationSummary, key : ApplicationSummaryKeys)
    {
        titleLabel.text = key.rawValue;
        dataTF.text =  appSummary.getValueFromKey(key: key);
        
        print("\(dataTF.text)")
    }

    
    func setApplicationSummaryDetails(_ : AnyObject)
    {
        
        
    }

    @IBAction func viewDetailsButtonTapped(_ sender: Any) {
        delegate?.rightActionButtonTapped()
        
    }
}
