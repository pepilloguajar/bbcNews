//
//  WebViewAuxRouter.swift
//  bbcNews
//
//  Created by JJ Montes on 15/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

protocol WebViewAuxRouterProtocol: AnyObject {
    
    func popToHome()
}

final class WebViewAuxRouter: BaseRouter<WebViewAuxPresenterProtocol, WebViewAuxView>, WebViewAuxRouterProtocol {
    
    // MARK: Internal functions declaration of all functions and protocol variables
    internal func popToHome() {
        self.view?.navigationController?.popViewController(animated: true)
    }
}
