//
//  MarvelRequests.swift
//  Marvel_Heroes
//
//  Created by Cristiano Salla Lunardi on 09/12/19.
//  Copyright © 2019 Cristiano Salla Lunardi. All rights reserved.
//

import Foundation
import UIKit

enum MarvelEndpoint {
    case comic(Int, Int)
    case char(Int)
    
    var url: URL {
        let endPoint = "http://gateway.marvel.com/v1/public/"
        let rChars = "characters"
        let rComics = "comics"
        let params = "ts=100&apikey=b3f27aa255c9ff500b9466758b917fdf&hash=587b8a37b2e0797c36578a5dd920c662"
        
        var urlString: String = "\(endPoint)"
        switch self {
        case .char(let offset):
            urlString += "\(rChars)?limit=20&offset=\(offset)&\(params)"
            return URL(string: urlString)!
        case .comic(let offset, let id):
            urlString += "\(rChars)/\(id)/\(rComics)?limit=20&offset=\(offset)&\(params)"
            return URL(string: urlString)!
        }
    }
}

final class MarvelHttpRequests<T:Decodable> {
    
    func requestData(endpoint: MarvelEndpoint, completion: @escaping (_ data: T) -> Void) {
        
        let task = URLSession.shared.dataTask(with: endpoint.url) {(data, response, error) in
            guard let data = data else { return }
            do {
                let results = try JSONDecoder().decode(MarvelResponse<T>.self, from: data)
                completion(results.data.results)
            } catch let err {
                print("error", err)
            }
        }
        task.resume()
    }
    
    func downloadImage(thumbnail: Thumbnail, completion: @escaping (_ image: String) -> Void) {
        
        let url = URL(string: "\(thumbnail.path).\(thumbnail.ext)")!
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            completion(data.base64EncodedString())
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
