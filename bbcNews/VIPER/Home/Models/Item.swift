//
//  Item.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

//Class that represents the model that should be used in the  view of Item
class Item {
    var title: String?
    var description: String?
    var link: String?
    var guid: String?
    var pubDate: Date?
    var thumbnail: Thumbnail?
    init() {}

}

//extension to initialize the model Item from its struct
extension Item {
    convenience init(itemEntity: ItemEntity?) {
        self.init()
        self.title = itemEntity?.title
        self.description = itemEntity?.description
        self.link = itemEntity?.link
        self.guid = itemEntity?.guid
        // Paso la fecha a "Date" para trabajar con ella en el futuro
        self.pubDate = itemEntity?.pubDate?.createDate(format: "E, dd MMM yyyy HH:mm:ss z")
        self.thumbnail = Thumbnail(thumbnailEntity: itemEntity?.thumbnail)
    }
}
