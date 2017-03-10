//
//  MCAApplicationSummaryTVCell.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/14/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

protocol MCAApplicationSummaryTVCellDelegate {
    
    func downloadButtonTapped()
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

    @IBAction func viewDetailsButtonTapped(_ sender: Any) {
        delegate?.downloadButtonTapped()
        
//        let storyBoard = UIStoryboard(name: StoryboardName.MCAMerchantApplication, bundle: Bundle.main)
//        let submitStipuationsVC = storyBoard.instantiateViewController(withIdentifier: VCIdentifiers.MCAMASubmitStipulationsVC) as! MCAMASubmitStipulationsVC
//        self.navigationController?.pushViewController(submitStipuationsVC, animated: true)
        
    }
}
