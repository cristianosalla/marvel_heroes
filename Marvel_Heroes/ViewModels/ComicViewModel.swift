//
//  ComicViewModel.swift
//  Marvel_Heroes
//
//  Created by Cristiano Salla Lunardi on 11/12/19.
//  Copyright © 2019 Cristiano Salla Lunardi. All rights reserved.
//

import UIKit

public class ComicViewModel: MarvelViewModelProtocol {
    
    var id: Int?
    var title: String
    var description: String?
    var thumbnail: Thumbnail
    var image: UIImage? {
        didSet {
            self.delegate?.updateImage(image: image!)
        }
    }
    
    
    private let comic: Comic
    
    init(comic: Comic) {
        self.comic = comic
        self.title = comic.title
        self.thumbnail = comic.thumbnail
        
        MarvelHttpRequests<Comic>().downloadImage(thumbnail: self.thumbnail) {
            (image) in
            if let dataImage = Data(base64Encoded: image) {
                self.image = UIImage(data: dataImage)
            }
        }
    }
    
    var delegate: UpdateImage?
}
