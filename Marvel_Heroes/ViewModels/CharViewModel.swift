//
//  CharViewModel.swift
//  Marvel_Heroes
//
//  Created by Cristiano Salla Lunardi on 10/12/19.
//  Copyright © 2019 Cristiano Salla Lunardi. All rights reserved.
//

import UIKit

public class CharViewModel: MarvelViewModelProtocol {

    var id: Int?
    var title: String
    var description: String?
    var thumbnail: Thumbnail
    var image: UIImage? {
        didSet {
            self.delegate?.updateImage(image: image!)
        }
    }
    
    
    private let char: Char
    
    init(char: Char) {
        self.char = char
        self.id = char.id
        self.title = char.name
        self.description = char.description
        self.thumbnail = char.thumbnail
         
        MarvelHttpRequests<Char>().downloadImage(thumbnail: self.thumbnail) {
            (image) in
            if let dataImage = Data(base64Encoded: image) {
                self.image = UIImage(data: dataImage)
            }
        }
    }
    
    weak var delegate: UpdateImage?
}
