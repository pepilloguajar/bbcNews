//
//  BaseInteractor.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

//Base class, it is declared as a good practice to implement new functions in a global way in the application.
class BaseInteractor <Presenter: Any>: NSObject {
    
    internal var presenter: Presenter?
    
    //Class initializer
    convenience init(presenter: Presenter? = nil) {
        self.init()
        self.presenter = presenter
    }
}
