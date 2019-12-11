//
//  Thumbnail.swift
//  Marvel_Heroes
//
//  Created by Cristiano Salla Lunardi on 11/12/19.
//  Copyright © 2019 Cristiano Salla Lunardi. All rights reserved.
//

import Foundation

struct Thumbnail: Decodable {
    private enum CodingKeys : String, CodingKey {
        case path = "path"
        case ext = "extension"
    }
    let path: String
    let ext: String
}
