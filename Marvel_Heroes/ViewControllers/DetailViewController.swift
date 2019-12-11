//
//  DetailViewController.swift
//  Marvel_Heroes
//
//  Created by Cristiano Salla Lunardi on 09/12/19.
//  Copyright © 2019 Cristiano Salla Lunardi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var charactersNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var updateIndexPaths: [IndexPath] = []
    var charViewModel: CharViewModel!
    private var comics: [ComicViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.performBatchUpdates({
                    self.collectionView.insertItems(at: self.updateIndexPaths)
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.charViewModel.delegate = self
        if let image = charViewModel.image {
            self.imageView.image = image
        }
        self.charactersNameLabel.text = charViewModel.title
        self.descriptionLabel.text = charViewModel.description
        
        collectionView.register(UINib(nibName: "MarvelCell", bundle: nil), forCellWithReuseIdentifier: "marvelCell")
        
        MarvelHttpRequests<[Comic]>().requestData(endpoint: .comic(0, self.charViewModel.id!)) { (comics:Array<Comic>) in
            self.comics = comics.map({ (comic) -> ComicViewModel in
                return ComicViewModel(comic: comic)
            })
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollViewWidth = scrollView.frame.size.width
        let scrollContentSizeWidth = scrollView.contentSize.width
        let scrollOffset = scrollView.contentOffset.x
        
        if (scrollOffset + scrollViewWidth >= scrollContentSizeWidth - 50)
        {
            MarvelHttpRequests<[Comic]>().requestData(endpoint: .comic(self.comics.count + 1, self.charViewModel.id!)) { (comics:Array<Comic>) in
                let arraySize = self.comics.count
                let newTotal = comics.count + self.comics.count
                self.updateIndexPaths = Array(arraySize..<newTotal).map { (num) -> IndexPath in
                    return IndexPath(row: num, section: 0)
                }
                
                self.comics = self.comics + comics.map({ (comic) -> ComicViewModel in
                    return ComicViewModel(comic: comic)
                })
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.view.frame.width-30)/3
        return CGSize(width: width, height: collectionView.bounds.height - 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "marvelCell", for: indexPath) as? MarvelCell else {
            return MarvelCell()
        }
        
        cell.imageView.contentMode = .scaleAspectFit
        cell.viewModel = self.comics[indexPath.row]
        return cell
    } 
}

extension DetailViewController: UpdateImage {
    func updateImage(image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
