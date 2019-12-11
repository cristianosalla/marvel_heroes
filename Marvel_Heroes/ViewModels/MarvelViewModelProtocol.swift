//
//  MarvelViewModel.swift
//  Marvel_Heroes
//
//  Created by Cristiano Salla Lunardi on 11/12/19.
//  Copyright © 2019 Cristiano Salla Lunardi. All rights reserved.
//

import UIKit

protocol UpdateImage: class {
    func updateImage(image: UIImage)
}

protocol MarvelViewModelProtocol: class {
    var id: Int? { get set }
    var title: String { get set }
    var description: String? {get set}
    var image: UIImage? { get set }
    var thumbnail: Thumbnail {get set}
    var delegate: UpdateImage? { get set }
}
