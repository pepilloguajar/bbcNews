//
//  bbcNewsUtils.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

class bbcNewsUtils {
    static func getXib(xibFile: XibFile) -> String {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return xibFile.rawValue
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            return xibFile.rawValue + "_iPad"
        } else {
            return ""
        }
    }
    
    static func isIpad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
