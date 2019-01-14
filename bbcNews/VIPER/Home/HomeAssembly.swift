//
//  HomeAssembly.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

final class HomeAssembly: BaseAssembly {
    
    static func homePresenterNavigationController(homeAssemblyDTO: HomeAssemblyDTO? = nil) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: self.homePresenterView(homeAssemblyDTO: homeAssemblyDTO))
        
        return navigationController
    }
    
    static func homePresenterView(homeAssemblyDTO: HomeAssemblyDTO? = nil) -> HomeView {
        
        let view = HomeView(nibName: bbcNewsUtils.getXib(xibFile: .homeView), bundle: nil)
        view.presenter = self.homePresenter(view: view)
        view.presenter?.homeAssemblyDTO = homeAssemblyDTO
        
        return view
    }
    
    static fileprivate func homePresenter(view: HomeView) -> HomePresenterProtocol {
        
        let presenter = HomePresenter(view: view)
        presenter.router = self.homeRouter(presenter: presenter, view: view)
        presenter.interactor = self.homeInteractor(presenter: presenter)
        
        return presenter
    }
    
    static fileprivate func homeRouter(presenter: HomePresenter, view: HomeView) -> HomeRouterProtocol {
        
        let router = HomeRouter(presenter: presenter, view: view)
        
        return router
    }
    
    static fileprivate func homeInteractor(presenter: HomePresenterProtocol) -> HomeInteractorProtocol {
        
        let interactor = HomeInteractor(presenter: presenter)
        interactor.provider = self.homeProvider()
        
        return interactor
    }
    
    static fileprivate func homeProvider() -> HomeProviderProtocol {
        
        let provider = HomeProvider()
        
        return provider
    }
}

//Struct that represents the transfer object of Home
struct HomeAssemblyDTO {
    
    let homeModel: NewsResponse? = nil
}
