//
//  MCAUtilities.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAUtilities: NSObject {
    
    
    static func isValidEmail(inEmailId:String) -> Bool
     {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: inEmailId)
    }


    static func getFontWithFontName(inFontName:String, size inFontSize:CGFloat ) -> UIFont
    {
        let font = UIFont(name:inFontName, size:inFontSize)!
        return font;
    }
    
    
  }


