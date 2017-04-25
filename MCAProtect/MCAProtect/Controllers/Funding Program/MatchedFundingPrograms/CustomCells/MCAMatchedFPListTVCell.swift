//
//  MatchedFPListTVCell.swift
//  MCAProtect
//
//  Created by Accion Labs on 08/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

protocol MatchedFundingProgramCellDelegate
{
    func programSelected(buttonTag : Int)
    func programDeSelected(buttonTag : Int)
    func showDetailOfFundingProgram(matchedFP: MCAFundingProgram)
    func setUpsellRate(object : MCAFundingProgram)

}

class MCAMatchedFPListTVCell: UITableViewCell {
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var checkButton : UIButton!
    @IBOutlet weak var loanRangeLabel : UILabel!
    @IBOutlet weak var loanRangeSubTitleLabel : UILabel!

    
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var upsellRateButton: UIButton!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var termLabel : UILabel!
    @IBOutlet weak var maxUpsellLabel : UILabel!
    @IBOutlet weak var buyRateLabel : UILabel!
    @IBOutlet weak var totalRatelLabel : UILabel!

    

    
    var indexPath : NSIndexPath!
    
    var shouldShowDetails : Bool?
    var selectedFundingProgram : MCAFundingProgram!
    var delegate : MatchedFundingProgramCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkButton.setImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
        checkButton.isSelected = false;
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }

    @IBAction func showDetails(_ sender: Any)
    {
       delegate?.showDetailOfFundingProgram(matchedFP: selectedFundingProgram)
   }
    
    func updateDataSource(matchedFundingProgramObject : MCAFundingProgram)  {
        
        selectedFundingProgram = matchedFundingProgramObject;
        
        titleLabel.text = matchedFundingProgramObject.fundingProgramName! as String
        let range  = MCAUtilities.currencyFormatter(inputItem: matchedFundingProgramObject.minimumLoan as AnyObject) as String! + " to " + MCAUtilities.currencyFormatter(inputItem: matchedFundingProgramObject.maximumLoan as AnyObject) as String!
        loanRangeLabel.text = range
        
        loanRangeSubTitleLabel.text = range

        
        buyRateLabel.text = matchedFundingProgramObject.buyRate + " %"
        maxUpsellLabel.text = matchedFundingProgramObject.maxUpsellRate + " %"
        
        let maxUpsell = float_t(matchedFundingProgramObject.maxUpsellRate)
        let totalRate =  float_t(matchedFundingProgramObject.buyRate)! + ( maxUpsell!/100)
        
        totalRatelLabel.text = "\(totalRate) %"
        let loanTerm = Int(matchedFundingProgramObject.term)
        let  loanTermMonths = (loanTerm! / 30)
        let  loanTermString = "\(loanTermMonths) months"
        termLabel.text = loanTermString
        let imageUrl = URL.init(string: matchedFundingProgramObject.programImage)
        logoImgView.sd_setImage(with: imageUrl)
        logoImgView.setIndicatorStyle(.gray)
        logoImgView.setShowActivityIndicator(true)
        
        upsellRateButton .setTitle(matchedFundingProgramObject.upsellRate! as String, for: UIControlState.normal)
        
        if matchedFundingProgramObject.isSelected! {
            checkButton.setImage(UIImage(named: "icon_checked"), for: UIControlState.normal)
            checkButton.isSelected = true;

        }
        else
        {
            checkButton.setImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
            checkButton.isSelected = false;
        }
    }
    
    @IBAction func checkButtonTapped ( _ sender: UIButton)
    {
        if (checkButton.isSelected == true)
        {
            checkButton.setImage(UIImage(named: "iconCheck"), for: UIControlState.normal)
            checkButton.isSelected = false;
            delegate?.programDeSelected(buttonTag: sender.tag)

        }
        else
        {
            checkButton.setImage(UIImage(named: "icon_checked"), for: UIControlState.normal)
            
            checkButton.isSelected = true;
            delegate?.programSelected(buttonTag: sender.tag)

        }
 
        
    }
    
    @IBAction func upsellRateBtnTapped()
    {        self.delegate?.setUpsellRate(object: selectedFundingProgram)
    
   }
    
}
