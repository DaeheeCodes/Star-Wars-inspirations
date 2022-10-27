//
//  imgModel.swift
//  Star Wars Inspo
//
//  Created by DHC on 10/26/22.
//

import Foundation

struct imgModel: Codable{
        var links: Links
}

struct Links: Codable {
    var `self`: String
    var html: String
    var download: String
    var download_location: String
}
