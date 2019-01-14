//
//  NewsResponse.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

//Class that represents the model that should be used in the  view of NewsResponse
class NewsResponse {
    var channel: Channel?
    init() {}

}

//extension to initialize the model NewsResponse from its struct
extension NewsResponse {
    convenience init(newsResponseEntity: NewsResponseEntity?) {
        self.init()
        self.channel = Channel(channelEntity: newsResponseEntity?.channel)
    }
}
