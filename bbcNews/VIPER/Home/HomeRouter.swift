//
//  HomeRouter.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

protocol HomeRouterProtocol: AnyObject {
    
    func goToWebView(dto: WebViewAuxAssemblyDTO)
}

final class HomeRouter: BaseRouter<HomePresenterProtocol, HomeView>, HomeRouterProtocol {
    
    // MARK: Internal functions declaration of all functions and protocol variables
    internal func goToWebView(dto: WebViewAuxAssemblyDTO) {
        self.view?.navigationController?.pushViewController(WebViewAuxAssembly.webViewAuxPresenterView(webViewAuxAssemblyDTO: dto), animated: true)
    }
}
