//
//  String+Extensions.swift
//  Utility
//
//  Created by L on 2022/2/11.
//

import Foundation

public extension String {
    
    func isEmail() -> Bool {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate.init(format: "SELF MATCHES%@", argumentArray: [emailRegex])
        return emailTest.evaluate(with: self)
        
    }
    
    func converToDate() -> Date? {
        let dateFromStringFormatter = DateFormatter()
        dateFromStringFormatter.dateFormat = CreateDataFormat
        return dateFromStringFormatter.date(from: self)
    }
    
}
