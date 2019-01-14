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
}

final class HomePresenter: BasePresenter<HomeView, HomeRouterProtocol, HomeInteractorProtocol>, HomePresenterProtocol {
    
    var homeAssemblyDTO: HomeAssemblyDTO?
    var newsModel: [Item] = []
    
    // MARK: Internal functions declaration of all functions and protocol variables
    internal func getNewsData() {
        self.getNewsDataAction()
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
        
    }
}
