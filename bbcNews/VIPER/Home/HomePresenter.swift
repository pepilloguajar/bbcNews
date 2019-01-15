//
//  HomePresenter.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

protocol HomePresenterProtocol: AnyObject {
    
    var homeAssemblyDTO: HomeAssemblyDTO? { get set }
    func getNewsData()
    var newsModel: [Item] { get set }
    func navigateToWebView(index: Int)
}

final class HomePresenter: BasePresenter<HomeView, HomeRouterProtocol, HomeInteractorProtocol>, HomePresenterProtocol {
    
    var homeAssemblyDTO: HomeAssemblyDTO?
    var newsModel: [Item] = []
    
    // MARK: Internal functions declaration of all functions and protocol variables
    internal func getNewsData() {
        self.getNewsDataAction()
    }
    
    internal func navigateToWebView(index: Int) {
        self.navigateToWebViewAction(index: index)
    }

    
    // MARK: Fileprivate functions declaration of all functions that return something to the protocol or perform an activity that should not be exposed
    fileprivate func getNewsDataAction() {
        
        self.interactor?.getNewsData(success: { newsModel in
            
            self.getNewsDataServiceLoaded(newsModel: newsModel)
            
        }, failure: { error in
            
            self.getNewsDataServiceLoaded()
            
        })
    }
    
    fileprivate func getNewsDataServiceLoaded(newsModel: [Item]? = nil) {
        
        guard let newsModel = newsModel else { return } // Gestionar errores
        
        self.newsModel = newsModel
        
        // Refrescamos la tabla con el contenido de noticias
        self.view?.tableView.reloadData()
        
    }
    
    fileprivate func navigateToWebViewAction(index: Int) {
        guard let urlString = self.newsModel[index].link else { return }
        let title = self.newsModel[index].title ?? "News Item"
        
        let dto = WebViewAuxAssemblyDTO(urlLoad: urlString, newsTitle: title)
        self.router?.goToWebView(dto: dto)
    }
}
