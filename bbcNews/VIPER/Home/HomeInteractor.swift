//
//  HomeInteractor.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

protocol HomeInteractorProtocol: AnyObject {
    
    func getNewsData(success: @escaping ([Item]?) -> Void, failure: @escaping (NSError) -> Void)
}

final class HomeInteractor: BaseInteractor<HomePresenterProtocol>, HomeInteractorProtocol {
    
    internal var provider: HomeProviderProtocol?
    
    // MARK: Internal functions declaration of all functions and protocol variables
    internal func getNewsData(success: @escaping ([Item]?) -> Void, failure: @escaping (NSError) -> Void) {
        self.getNewsDataAction(success: success, failure: failure)
    }
    
    // MARK: Fileprivate functions declaration of all functions that return something to the protocol or perform an activity that should not be exposed
    fileprivate func getNewsDataAction(success: @escaping ([Item]?) -> Void, failure: @escaping (NSError) -> Void) {
        
        self.provider?.getNewsData(success: { (newsResponse) in
            let news: [Item]? = newsResponse?.channel?.item
            success(news)
        }, failure: failure)
        
    }
}
