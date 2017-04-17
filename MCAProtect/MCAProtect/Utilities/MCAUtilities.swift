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
    
    static func hexStringToUIColor (hexaDecimalString:String) -> UIColor {
        var cString:String = hexaDecimalString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func currencyFormatter(inputItem: AnyObject) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.maximumFractionDigits = 2
        return formatter.string(from: inputItem as! NSNumber)!
    }

    static func getBaseURL(environment: String) -> String
    {
        let settingsDict = Bundle.main.infoDictionary!
        let EnvironmentString = settingsDict[environment] as! String
        let environmentDict = settingsDict[EnvironmentString] as! NSDictionary
        return environmentDict.value(forKey: "BASE_URL") as! String
    }

    static func getImageBaseURL(environment: String) -> String
    {
        let settingsDict = Bundle.main.infoDictionary!
        let EnvironmentString = settingsDict[environment] as! String
        let environmentDict = settingsDict[EnvironmentString] as! NSDictionary
        return environmentDict.value(forKey: "IMAGE_BASE_URL") as! String
    }

    
    static func blur(viewToBlur:UIView! , blurView : UIView!)
    {
        var bView = blurView as UIView!
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        bView = UIVisualEffectView(effect: blurEffect)
        bView?.isUserInteractionEnabled = false
        bView?.frame = viewToBlur.bounds
        viewToBlur.addSubview(bView!)
    }

    
    static func getnilcheckedStringValue(stringToNilCheck : String?) -> String {
        
        return stringToNilCheck == nil ? "" : stringToNilCheck!
        
    }
    
    static func getnilcheckedIntValue(IntegerToNilCheck : Int?) -> Int {
        
        return IntegerToNilCheck == nil ? 0 : IntegerToNilCheck!
        
    }
    
    static  func FormattedStringFromDate(date : Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let DateFormated = dateFormatter.string(from: date)
        print(DateFormated)
        return DateFormated
    }
    
    static  func getFormmattedDate(dateString : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let formattedDate =  dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from:formattedDate!)
        return dateString
    }

    static func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    
}
