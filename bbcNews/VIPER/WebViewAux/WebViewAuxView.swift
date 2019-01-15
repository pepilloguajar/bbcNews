//
//  WebViewAuxView.swift
//  bbcNews
//
//  Created by JJ Montes on 15/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewAuxView: BaseView<WebViewAuxPresenterProtocol>, WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate {
    // MARK: IBOutlets declaration of all controls
    @IBOutlet weak var navigationBar: BaseNavigationBar!
    @IBOutlet weak var webView: WKWebView!
    
    
    // MARK: Fileprivate Variables all variables must be for internal use, we should only have access to controls from the presenter
    
    // MARK: UIViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlString: String = self.presenter?.webViewAuxAssemblyDTO?.urlLoad {
            let htmlUrl = URL(string: urlString)
            let sec = URLRequest(url: htmlUrl!)
            self.webView.load(sec)
        }
    }
    
    // MARK: IBActions declaration of all the controls
    
    // MARK: Private Functions
    
    // Configuramos la navigation bar
    func customizeNavigationBar() {
        self.navigationBar.viewModel = BaseNavigationBarModel(title: self.presenter?.webViewAuxAssemblyDTO?.newsTitle ?? "",
                                                              leftButton: .back,
                                                              rightButton: .none,
                                                              showViewBottomLine: true)
        
        self.navigationBar.delegate = self
        self.navigationBar.setWhiteStyle()
    }
    
    // MARK: Delegados del WKWebView para controlar la carga del mismo y sus errores
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        BBCNewsLoader.hideProgressHud()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        BBCNewsLoader.hideProgressHud()
    }
}

// MARK: Extensions declaration of all extension and implementations of protocols
extension WebViewAuxView: BaseViewControllerViewDidLoadProtocol {
    
    func i18N() {
        
    }
    
    func initializeGUI() {
        
        //Mostramos el loader hasta que cargue la url
        BBCNewsLoader.showProgressHud(fullScreen: false)

        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        self.webView.contentMode = .scaleAspectFit
        self.webView.backgroundColor = UIColor.white
        self.webView.scrollView.delegate = self
        self.webView.scrollView.bounces = false
    }
}

extension WebViewAuxView: BaseViewControllerViewWillAppearProtocol {
    
    func callWebService() {

    }
    
    func manageGUI() {
        
        self.customizeNavigationBar()
        
    }
}

extension WebViewAuxView: BaseViewControllerRefresh {
    func backToBackGroundRefresh() {}
}

extension WebViewAuxView: BaseNavigationBarDelegate {
    func leftButtonAction() {
        self.presenter?.goToHome()
    }
    
    func rightButtonAction() {
        
    }
    
}
