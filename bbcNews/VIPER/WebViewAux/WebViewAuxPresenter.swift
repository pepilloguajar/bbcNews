//
//  WebViewAuxPresenter.swift
//  bbcNews
//
//  Created by JJ Montes on 15/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

protocol WebViewAuxPresenterProtocol: AnyObject {
    
    var webViewAuxAssemblyDTO: WebViewAuxAssemblyDTO? { get set }
    func goToHome()
}

final class WebViewAuxPresenter: BasePresenter<WebViewAuxView, WebViewAuxRouterProtocol, WebViewAuxInteractorProtocol>, WebViewAuxPresenterProtocol {
    
    var webViewAuxAssemblyDTO: WebViewAuxAssemblyDTO?
    
    // MARK: Internal functions declaration of all functions and protocol variables
    internal func goToHome() {
        self.goToHomeAction()
    }
    
    // MARK: Fileprivate functions declaration of all functions that return something to the protocol or perform an activity that should not be exposed
    fileprivate func goToHomeAction() {
        //Quitamos el "loader" por si la carga del webView se queda bloqueada
        BBCNewsLoader.hideProgressHud()
        
        self.router?.popToHome()
    }
}
