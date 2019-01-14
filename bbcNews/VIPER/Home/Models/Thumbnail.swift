//
//  Thumbnail.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

//Class that represents the model that should be used in the  view of Thumbnail
class Thumbnail {
    var width: String?
    var height: String?
    var url: String?
    init() {}

}

//extension to initialize the model Thumbnail from its struct
extension Thumbnail {
    convenience init(thumbnailEntity: ThumbnailEntity?) {
        self.init()
        self.width = thumbnailEntity?.width
        self.height = thumbnailEntity?.height
        self.url = thumbnailEntity?.url
    }
}
