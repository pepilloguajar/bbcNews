//
//  UINavigationBar+Extension.swift
//  JiboReminderHealthcare
//
//  Created by Marco Antonio Uzcategui Pescozo on 19/03/2018.
//  Copyright © 2018 Marco Antonio Uzcategui Pescozo. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    public func setBottomBorderColor(color: UIColor) {
        
        let navigationSeparator = UIView(frame: CGRect(x: 0, y: self.frame.size.height - 0.5, width: self.frame.size.width, height: 0.5))
        navigationSeparator.backgroundColor = color
        navigationSeparator.isOpaque = true
        navigationSeparator.tag = 123
        if let oldView = self.viewWithTag(123) {
            oldView.removeFromSuperview()
        }
        self.addSubview(navigationSeparator)
    }
    
    public func setBottomBorderImage(image: UIImage) {
        
        let navigationSeparator = UIImageView(frame: CGRect(x: 0, y: self.frame.size.height - 0.5, width: self.frame.size.width, height: image.size.height))
        navigationSeparator.image = image
        navigationSeparator.isOpaque = true
        navigationSeparator.tag = 123
        if let oldView = self.viewWithTag(123) {
            oldView.removeFromSuperview()
        }
        self.addSubview(navigationSeparator)
    }
}
