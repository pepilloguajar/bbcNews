//
//  ChannelEntity.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation

struct ChannelEntity: Codable {
    let title: String?
    let description: String?
    let link: String?
    let image: ImageEntity?
    let generator: String?
    let lastBuildDate: String?
    let copyright: String?
    let language: String?
    let ttl: String?
    let item: [ItemEntity]?
}
