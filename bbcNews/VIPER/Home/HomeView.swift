//
//  HomeView.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

class HomeView: BaseView<HomePresenterProtocol> {
    // MARK: IBOutlets declaration of all controls
    
    // MARK: Fileprivate Variables all variables must be for internal use, we should only have access to controls from the presenter
    
    // MARK: UIViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: IBActions declaration of all the controls
    
    // MARK: Private Functions
}

// MARK: Extensions declaration of all extension and implementations of protocols
extension HomeView: BaseViewControllerViewDidLoadProtocol {
    
    func i18N() {
        
        self.title = "Home"
    }
    
    func initializeGUI() {

    }
}

extension HomeView: BaseViewControllerViewWillAppearProtocol {
    
    func callWebService() {
        
        self.presenter?.getNewsData()
    }
    
    func manageGUI() {
        
    }
}

extension HomeView: BaseViewControllerRefresh {
    func backToBackGroundRefresh() {}
}
