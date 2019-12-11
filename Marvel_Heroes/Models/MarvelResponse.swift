//
//  MarvelResponse.swift
//  Marvel_Heroes
//
//  Created by Cristiano Salla Lunardi on 11/12/19.
//  Copyright © 2019 Cristiano Salla Lunardi. All rights reserved.
//

import Foundation

struct MarvelResponse<ResultType: Decodable>: Decodable {
    let data: Results<ResultType>
}

struct Results<ResultType: Decodable>: Decodable  {
    let results: ResultType
}
