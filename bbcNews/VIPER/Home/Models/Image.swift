//
//  Image.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

//Class that represents the model that should be used in the  view of Image
class Image {
    var url: String?
    var title: String?
    var link: String?
    init() {}

}

//extension to initialize the model Image from its struct
extension Image {
    convenience init(imageEntity: ImageEntity?) {
        self.init()
        self.url = imageEntity?.url
        self.title = imageEntity?.title
        self.link = imageEntity?.link
    }
}
