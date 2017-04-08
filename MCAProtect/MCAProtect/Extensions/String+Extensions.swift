//
//  String+Extensions.swift
//  MCAProtect
//
//  Created by Sarath NS on 2/21/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import Foundation

public extension String {
    
    func isValidAsEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidAsPhone() -> Bool {
        let phoneRegEx = "^[0-9-+]{9,15}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
    
    func getFirstAndLastName() -> (String, String)? {
        guard let range = trimmingCharacters(in: CharacterSet.whitespaces).range(of: " ", options: .backwards,
                                                                                 range: nil, locale: nil)
            else {
                return nil
            }
        let first = substring(to: range.lowerBound)
        let last = substring(from: range.upperBound)
        return (first, last)
    }
    
    func toUSPhoneNumberFormat() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
}

