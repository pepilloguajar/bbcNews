//
//  Channel.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

//Class that represents the model that should be used in the  view of Channel
class Channel {
    var title: String?
    var description: String?
    var link: String?
    var image: Image?
    var generator: String?
    var lastBuildDate: String?
    var copyright: String?
    var language: String?
    var ttl: String?
    var item: [Item]?
    init() {}

}

//extension to initialize the model Channel from its struct
extension Channel {
    convenience init(channelEntity: ChannelEntity?) {
        self.init()
        self.title = channelEntity?.title
        self.description = channelEntity?.description
        self.link = channelEntity?.link
        self.image = Image(imageEntity: channelEntity?.image)
        self.generator = channelEntity?.generator
        self.lastBuildDate = channelEntity?.lastBuildDate
        self.copyright = channelEntity?.copyright
        self.language = channelEntity?.language
        self.ttl = channelEntity?.ttl
        self.item = channelEntity?.item?.map{ Item(itemEntity: $0) }
        
    }
}
