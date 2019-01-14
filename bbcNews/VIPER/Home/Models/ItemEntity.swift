//
//  ItemEntity.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
struct ItemEntity: Codable {
    let title: String?
    let description: String?
    let link: String?
    let guid: String?
    let pubDate: String?
    let thumbnail: ThumbnailEntity?
    
    enum CodingKeys: String, CodingKey {
        case title, description, link, guid, pubDate
        case thumbnail = "media:thumbnail"
    }
}
