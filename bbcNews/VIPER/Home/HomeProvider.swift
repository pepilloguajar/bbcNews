//
//  HomeProvider.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import Alamofire
import XMLParsing

protocol HomeProviderProtocol: AnyObject {

    func getNewsData(success: @escaping (NewsResponse?) -> Void, failure: @escaping (NSError) -> Void)
}

final class HomeProvider: BaseProvider, HomeProviderProtocol {
    
    // MARK: Internal functions declaration of all functions and protocol variables
    internal func getNewsData( success: @escaping (NewsResponse?) -> Void, failure: @escaping (NSError) -> Void) {
        self.getNewsDataService(success: success, failure: failure)
    }
    
    // MARK: Fileprivate functions declaration of all functions that return something to the protocol or perform an activity that should not be exposed
    fileprivate func getNewsDataService(success: @escaping (NewsResponse?) -> Void, failure: @escaping (NSError) -> Void) {

        _ = self.getProviderData(dto: ProviderDTO(params: nil,
                                                  method: HomeProviderConstants.HomeRequest.method,
                                                  endpoint: HomeProviderConstants.HomeRequest.endpoint),
                                 baseURL: "https://feeds.bbci.co.uk",
                                 success: { data in
                                    
                                    guard let newsResponseEntity = try? XMLDecoder().decode(NewsResponseEntity.self, from: data) else {
                                        success (nil)
                                        return
                                    }
                                    let newsResponse = NewsResponse(newsResponseEntity: newsResponseEntity)

                                    success(newsResponse)

        }, failure: { error in

            failure(error)
        })
    }
}


private struct HomeProviderConstants {
    struct HomeRequest {
        static let endpoint: String = "/news/world/rss.xml"
        static let method: HTTPMethod = .get
    }
}
