//
//  BaseView.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewControllerViewDidLoadProtocol {
    
    func i18N() // Internacionalicación de los literales
    func initializeGUI() // Inicialización de los componentes gráficos
}

protocol BaseViewControllerViewWillAppearProtocol {
    
    func callWebService() // Llamadas a Servicios Web
    func manageGUI() // Modificación de los componentes gráficos
}

//Class responsible for referencing the view with its presenter.
//Base class, it is declared as a good practice to implement new functions in a global way in the application.
class BaseView<Presenter: Any>: BaseViewController {
    
    internal var presenter: Presenter?
    var isPush: Bool = true // Necesario para realizar el refresh de la pantalla, solo cuando se hace push, y no pop.
    
    deinit {
        self.presenter = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewController = self as? BaseViewControllerViewDidLoadProtocol {
            
            viewController.i18N()
            viewController.initializeGUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewController = self as? BaseViewControllerViewWillAppearProtocol {
            
            // Si es push, y la pantalla implementa el refresh, se refresca la información de la pantalla.
            if self.isPush {
                
                viewController.callWebService()
            }
            viewController.manageGUI()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.isPush = false
    }
}
