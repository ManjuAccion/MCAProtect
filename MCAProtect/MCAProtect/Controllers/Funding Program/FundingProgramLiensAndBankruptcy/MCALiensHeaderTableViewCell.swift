//
//  MCALiensHeaderTableViewCell.swift
//  MCAProtect
//
//  Created by Accion Labs on 07/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCALiensHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerTextLabel: UILabel!
    @IBOutlet weak var stateImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLiensHeader(businessInfo: MCABusinessInformation, index: Int) {
        
        switch index {
            case LiensPayementsHeaderCell.judgementsOrLiens.rawValue:
                
                self.headerTextLabel.text = "Any judgement or liens"
                
                if businessInfo.judgementsOrLiens == true {
                    self.stateImageView.image = UIImage(named:"iconYesBlue")
                } else {
                    self.stateImageView.image = UIImage(named:"iconNoBlue")
                }
            case LiensPayementsHeaderCell.payementPlan.rawValue:
                
                self.headerTextLabel.text = "Are you currently in payement plan?"
                
                if businessInfo.paymentPlan == true {
                    self.stateImageView.image = UIImage(named:"iconYesBlue")
                } else {
                    self.stateImageView.image = UIImage(named:"iconNoBlue")
                }
            case LiensPayementsHeaderCell.bankruptcy.rawValue:
                
                self.headerTextLabel.text = "Have you ever filed for bankruptcy"
            
                if businessInfo.paymentPlan == true {
                    self.stateImageView.image = UIImage(named:"iconYesBlue")
                } else {
                    self.stateImageView.image = UIImage(named:"iconNaBlue")
                }
            default: break
        }
        
    }
    
    func setLiensHeader(fpLiensOrBankruptcy: MCAFPLiensOrBankruptcy, index: Int) {
        
        switch index {
        case LiensPayementsHeaderCell.judgementsOrLiens.rawValue:
            
            self.headerTextLabel.text = "Any judgement or liens"
            
            if fpLiensOrBankruptcy.judegementsORLiens == true {
                self.stateImageView.image = UIImage(named:"iconYesBlue")
            } else {
                self.stateImageView.image = UIImage(named:"iconNoBlue")
            }
        case LiensPayementsHeaderCell.payementPlan.rawValue:
            
            self.headerTextLabel.text = "Are you currently in payement plan?"
            
            if fpLiensOrBankruptcy.paymentPlan == true {
                self.stateImageView.image = UIImage(named:"iconYesBlue")
            } else {
                self.stateImageView.image = UIImage(named:"iconNoBlue")
            }
        case LiensPayementsHeaderCell.bankruptcy.rawValue:
            
            self.headerTextLabel.text = "Have you ever filed for bankruptcy"
            
            if fpLiensOrBankruptcy.paymentPlan == true {
                self.stateImageView.image = UIImage(named:"iconYesBlue")
            } else {
                self.stateImageView.image = UIImage(named:"iconNaBlue")
            }
        default: break
        }
        
    }

    
}
