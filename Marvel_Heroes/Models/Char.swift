//
//  Characters.swift
//  Marvel_Heroes
//
//  Created by Cristiano Salla Lunardi on 09/12/19.
//  Copyright © 2019 Cristiano Salla Lunardi. All rights reserved.
//

import Foundation

struct Char: Decodable {
    
    var id: Int
    var name: String
    var description: String
    var thumbnail: Thumbnail
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case thumbnail = "thumbnail"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        thumbnail = try values.decode(Thumbnail.self, forKey: .thumbnail)
        description = try values.decode(String.self, forKey: .description)
        image = ""
    }
    
}

