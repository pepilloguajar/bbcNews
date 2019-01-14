//
//  NSObject+Extension.swift
//  JiboReminderHealthcare
//
//  Created by Marco Antonio Uzcategui Pescozo on 19/03/2018.
//  Copyright © 2018 Marco Antonio Uzcategui Pescozo. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    class var nameOfClass: String {
        return String(describing: self)
    }
}
