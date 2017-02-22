//
//  UIApplication+Extensions.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

public extension UIApplication {
    
    public static var buildVersion: String {
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    public static var appVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public static var bundleName: String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    public static func makePhoneCall(_ phoneNumber: String) -> Bool {
        guard let phoneNumberUrl = URL(string: phoneNumber), UIApplication.shared.canOpenURL(phoneNumberUrl) else {
            return false
        }
        return UIApplication.shared.openURL(phoneNumberUrl)
    }
}
