//
//  MCADealsPipelineCell.swift
//  MCAProtect
//
//  Created by Manjunath on 14/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCADealsPipelineTVCell: UITableViewCell {

    @IBOutlet weak var pipelineTitleLabel: UILabel!
    @IBOutlet weak var applicationCountLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var leftView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        var colorWheel = ColorWheel()
        let randomColor = colorWheel.randomColor()
        leftView.backgroundColor = randomColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDealsPipeline(dealsPipeline:MCADealsPipeLine) {
        
        pipelineTitleLabel.text = dealsPipeline.applicationStateName
        applicationCountLabel.text =  "\(dealsPipeline.applicationCount!)"
        sumLabel.text = MCAUtilities.currencyFormatter(inputItem: dealsPipeline.sum as AnyObject)
        averageLabel.text = MCAUtilities.currencyFormatter(inputItem: dealsPipeline.average as AnyObject)
    }
    
    
}
