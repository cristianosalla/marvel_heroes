//
//  CharactersCell.swift
//  Marvel_Heroes
//
//  Created by Cristiano Salla Lunardi on 09/12/19.
//  Copyright © 2019 Cristiano Salla Lunardi. All rights reserved.
//

import UIKit

class MarvelCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    public var viewModel: MarvelViewModelProtocol? {
        willSet {
            self.viewModel?.delegate = nil
        }
        didSet {
            self.startActivityIndicator()
            self.viewModel?.delegate = self
            self.label.text = viewModel?.title
            self.stopActivityIndicator()
        }
    }
    
    override func prepareForReuse() {
        self.startActivityIndicator()
    }
    
    private func startActivityIndicator() {
        self.imageView.image = nil
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
    
    private func stopActivityIndicator() {
        if let img = self.viewModel?.image {
            self.imageView.image = img
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
}

extension MarvelCell: UpdateImage {
    func updateImage(image: UIImage) {
        DispatchQueue.main.async {
            self.stopActivityIndicator()
        }
    }
}
