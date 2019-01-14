//
//  String+Extension.swift
//  JiboReminderHealthcare
//
//  Created by Marco Antonio Uzcategui Pescozo on 19/03/2018.
//  Copyright © 2018 Marco Antonio Uzcategui Pescozo. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    public var localized: String {
        
        return NSLocalizedString(self, comment: "")
    }
    
    //Log functions
    public func infoLog(functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        var className = (fileName as NSString).lastPathComponent
        className = (className.replacingOccurrences(of: ".swift", with: ""))
        
        print("ℹ️ [\(className).\(functionName)] : \(self)")
    }
    public func sucessLog(functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        var className = (fileName as NSString).lastPathComponent
        className = (className.replacingOccurrences(of: ".swift", with: ""))
        
        print("✅ [\(className).\(functionName)] : \(self)")
    }
    public func errorLog(functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        var className = (fileName as NSString).lastPathComponent
        className = (className.replacingOccurrences(of: ".swift", with: ""))
        
        print("🆘 [\(className).\(functionName) ErrorLine:\(lineNumber)] : \(self)")
    }
    
    func createDate(format: String) -> Date {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.date(from: self)
        
        return dateString!
    }
    
    func substringWithRegularExpression (regularExpression: String) -> String {
        
        var subString: String? = ""
        
        do {
            
            let regex = try NSRegularExpression(pattern: regularExpression, options: [])
            let nsString = self as NSString
            
            let results = regex.matches(in: self, options: [], range: NSRange(location: 0, length: nsString.length))
            subString = results.map { nsString.substring(with: $0.range) }.first
            
            if subString == nil {
                
                subString = self
                
            }
            
        } catch let error as NSError {
            
            subString = self
            print(error)
            
        }
        
        return subString!
    }
    
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    var length: Int {
        return self.count
    }
    
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    subscript (index: Int) -> String {
        return self[index ..< index + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (range: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, range.lowerBound)),
                                            upper: min(length, max(0, range.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
