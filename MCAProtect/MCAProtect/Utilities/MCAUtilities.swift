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
    
    static  func formattedStringFromDate(date : Date) -> String
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
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from:formattedDate!)
        return dateString
    }
    
    static func getDateFromString(dateString: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let formattedDate = dateFormatter.date(from: dateString)
        return formattedDate!
    }
    
    static func mmddyyyyFormatterFromString(inputString : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate =  dateFormatter.date(from: inputString)
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from:formattedDate!)
        return dateString
    }

    static func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    static func getMonthFromDate(days:Int) -> String {
        
        var month : String
        
        if days <= 30 {
            
            month = "\(days) days"
        }
        else {
            let caluclatedMonth = days / 30
            month = "\(caluclatedMonth) months"
        }
        return month
        
    }
    
    static func emptyDataLabel(rect:CGRect) -> UILabel {
        
        let noDataLabel  = UILabel(frame: CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
        noDataLabel.text = "No Data Available"
        noDataLabel.textColor = UIColor(red: 45.0/255.0, green: 57.0/255.0, blue: 67.0/255.0, alpha: 1.0)
        noDataLabel.textAlignment = NSTextAlignment.center
        noDataLabel.isHidden = true
        
        return noDataLabel
    }
    
    static func daysBetweenDate(startDate: Date, endDate: Date) -> String {
        
        let calendar = NSCalendar.current
        var differenceValue : String!
        
        let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: startDate, to: endDate)
        
        if components.year! > 0 {
            differenceValue = "\(components.year!) Years ago"
        }
        else if components.month! > 0 {
            differenceValue = "\(components.month!) Months ago"
        }
        else if components.day! > 0 {
            
            if components.hour == 23 && components.minute == 59 && components.second == 59 {
                differenceValue = "\(components.day! + 1) Days ago"
            }
            else {
                differenceValue = "\(components.day!) Days ago"
            }
        }
        else if components.hour! > 0 {
            
            if components.minute == 59 && components.second == 59 {
                differenceValue = "\(components.hour! + 1) Hours ago"
            }
            else {
                differenceValue = "\(components.hour!) Hours ago"
            }
        }
        else if components.minute! > 0 {
            
            if components.second == 59 {
                differenceValue = "\(components.minute! + 1) Minutes ago"
            }
            else {
                differenceValue = "\(components.minute!) Minutes ago"
            }
        }
        else if components.second! > 0 {
            differenceValue = "\(components.second!) Seconds ago"
        }
        
        return differenceValue
    }
    
    
}
