//
//  SecureInputView.swift
//  Test
//
//  Created by Sarath NS on 2/7/17.
//  Copyright © 2017 Sarath NS. All rights reserved.
//

import Foundation
import UIKit

class SecureInputView : UIView {
    
    var inputLabel: UILabel!
    var inputImageView: UIImageView!
    var initialPlaceholderView: UIView!

    var inputImage: UIImage?
    
    override init (frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        
        inputImageView = UIImageView.init(frame: CGRect(x:0,y:0,width:0,height:0))
        inputImageView.image = UIImage(named: "pinPlacement")
        inputImageView.contentMode = .scaleAspectFit
//        inputImageView.isHidden = true
        self.addSubview(inputImageView)
        
        inputLabel = UILabel.init(frame: CGRect(x:0,
                                                y:0,
                                            width:0,
                                           height:0))
        inputLabel.textAlignment = .center
        self.addSubview(inputLabel)
        
        initialPlaceholderView = UIView.init(frame: CGRect(x:0,y:0,width:0,height:0))
        initialPlaceholderView.backgroundColor = UIColor.red
//        self.addSubview(initialPlaceholderView)

    }
    
    override func layoutSubviews() {
        
        //inputImageView Constraints
        
        let inputImageViewCenterX = NSLayoutConstraint(item: inputImageView,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                       toItem: self,
                                    attribute: .centerX,
                                   multiplier: 1.0,
                                     constant: 0)
        
        let inputImageViewCenterY = NSLayoutConstraint(item: inputImageView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                            toItem: self,
                                         attribute: .centerY,
                                        multiplier: 1.0,
                                          constant: 0)
        
        let inputImageViewWidth = NSLayoutConstraint(item: inputImageView,
                                            attribute: .width,
                                            relatedBy: .equal,
                                               toItem: self,
                                            attribute: .width,
                                           multiplier: 0.2,
                                             constant: 0)
        
        let inputImageViewHeight = NSLayoutConstraint(item: inputImageView,
                                             attribute: .height,
                                             relatedBy: .equal,
                                                toItem: self,
                                             attribute: .height,
                                            multiplier: 0.2,
                                              constant: 0)
        
        inputImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([inputImageViewCenterX,
                                     inputImageViewCenterY,
                                     inputImageViewWidth,
                                     inputImageViewHeight])
        //inputLabel Constraints

        let inputLabelCenterX = NSLayoutConstraint(item: inputLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0)
        
        let inputLabelCenterY = NSLayoutConstraint(item: inputLabel,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0)
        
        let inputLabelWidth = NSLayoutConstraint(item: inputLabel,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .width,
                                                 multiplier: 1.0,
                                                 constant: 0)
        
        let inputLabelHeight = NSLayoutConstraint(item: inputLabel,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .height,
                                                  multiplier: 1.0,
                                                  constant: 0)
        
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([inputLabelCenterX,
                                     inputLabelCenterY,
                                     inputLabelWidth,
                                     inputLabelHeight]);
        
        //initialPlaceholderView Constarints
        
//        let initialPlaceholderViewBottom = NSLayoutConstraint(item: initialPlaceholderView,
//                                                   attribute: .bottom,
//                                                   relatedBy: .equal,
//                                                   toItem: self,
//                                                   attribute: .bottom,
//                                                   multiplier: 1.0,
//                                                   constant: -2)
//        
//        let initialPlaceholderViewCenterX = NSLayoutConstraint(item: initialPlaceholderView,
//                                                   attribute: .centerX,
//                                                   relatedBy: .equal,
//                                                   toItem: self,
//                                                   attribute: .centerX,
//                                                   multiplier: 1.0,
//                                                   constant: 0)
//        
//        let initialPlaceholderViewWidth = NSLayoutConstraint(item: initialPlaceholderView,
//                                                 attribute: .width,
//                                                 relatedBy: .equal,
//                                                 toItem: self,
//                                                 attribute: .width,
//                                                 multiplier: 0.6,
//                                                 constant: 0)
//        
//        let initialPlaceholderViewHeight = NSLayoutConstraint(item: initialPlaceholderView,
//                                                  attribute: .height,
//                                                  relatedBy: .equal,
//                                                  toItem: self,
//                                                  attribute: .height,
//                                                  multiplier: 0,
//                                                  constant: 1)
        
//        initialPlaceholderView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([initialPlaceholderViewBottom,
//                                     initialPlaceholderViewCenterX,
//                                     initialPlaceholderViewWidth,
//                                     initialPlaceholderViewHeight]);
    }
    
    
}
