//
//  WebViewAuxAssembly.swift
//  bbcNews
//
//  Created by JJ Montes on 15/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

final class WebViewAuxAssembly: BaseAssembly {
    
    static func webViewAuxPresenterNavigationController(webViewAuxAssemblyDTO: WebViewAuxAssemblyDTO? = nil) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: self.webViewAuxPresenterView(webViewAuxAssemblyDTO: webViewAuxAssemblyDTO))
        
        return navigationController
    }
    
    static func webViewAuxPresenterView(webViewAuxAssemblyDTO: WebViewAuxAssemblyDTO? = nil) -> WebViewAuxView {
        
        let view = WebViewAuxView(nibName: bbcNewsUtils.getXib(xibFile: .webViewAuxView), bundle: nil)
        view.presenter = self.webViewAuxPresenter(view: view)
        view.presenter?.webViewAuxAssemblyDTO = webViewAuxAssemblyDTO
        
        return view
    }
    
    static fileprivate func webViewAuxPresenter(view: WebViewAuxView) -> WebViewAuxPresenterProtocol {
        
        let presenter = WebViewAuxPresenter(view: view)
        presenter.router = self.webViewAuxRouter(presenter: presenter, view: view)
        presenter.interactor = self.webViewAuxInteractor(presenter: presenter)
        
        return presenter
    }
    
    static fileprivate func webViewAuxRouter(presenter: WebViewAuxPresenter, view: WebViewAuxView) -> WebViewAuxRouterProtocol {
        
        let router = WebViewAuxRouter(presenter: presenter, view: view)
        
        return router
    }
    
    static fileprivate func webViewAuxInteractor(presenter: WebViewAuxPresenterProtocol) -> WebViewAuxInteractorProtocol {
        
        let interactor = WebViewAuxInteractor(presenter: presenter)
        
        return interactor
    }
}

//Struct that represents the transfer object of WebViewAux
struct WebViewAuxAssemblyDTO {
    
    let urlLoad: String?
    let newsTitle: String?
}
