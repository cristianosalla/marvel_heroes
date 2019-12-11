//
//  Comic.swift
//  Marvel_Heroes
//
//  Created by Cristiano Salla Lunardi on 11/12/19.
//  Copyright © 2019 Cristiano Salla Lunardi. All rights reserved.
//

import Foundation

struct Comic: Decodable {
    var title: String
    var thumbnail: Thumbnail
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case thumbnail = "thumbnail"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        thumbnail = try values.decode(Thumbnail.self, forKey: .thumbnail)
        image = ""
    }
}
