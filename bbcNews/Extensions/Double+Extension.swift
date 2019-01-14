//
//  Double+Extension.swift
//  JiboReminderHealthcare
//
//  Created by Marco Antonio Uzcategui Pescozo on 19/03/2018.
//  Copyright © 2018 Marco Antonio Uzcategui Pescozo. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    
    func formatCurrency(showSign: Bool = false, currencySymbol: String? = nil, numberOfDecimales: Int = 0) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = numberOfDecimales
        
        if let currencySymbol = currencySymbol {
            
            formatter.currencySymbol = currencySymbol
            formatter.numberStyle = .currency
        }
        
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: self as NSNumber)
        
        if showSign {
            
            if self >= 0 {
                
                return "+".appending(result!)
            }
        }
        
        return result!
    }
    
    func round(numberOfDecimales: Int) -> String {
        
        return self.formatCurrency(showSign: false, currencySymbol: nil, numberOfDecimales: numberOfDecimales)
        
    }
}
