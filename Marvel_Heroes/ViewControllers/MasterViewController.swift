//
//  MasterViewController.swift
//  Marvel_Heroes
//
//  Created by Cristiano Salla Lunardi on 09/12/19.
//  Copyright © 2019 Cristiano Salla Lunardi. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    private var updateIndexPaths: [IndexPath] = []
    var chars: [CharViewModel] = [] {
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
        
        self.collectionView.register(UINib(nibName: "MarvelCell", bundle: nil), forCellWithReuseIdentifier: "marvelCell")
        
        MarvelHttpRequests<[Char]>().requestData(endpoint: .char(0)) { (chars:Array<Char>) in
            self.chars = chars.map({ (char) -> CharViewModel in
                return CharViewModel(char: char)
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            if let indexPath = self.collectionView.indexPathsForSelectedItems?.first {
                let controller = segue.destination as! DetailViewController
                controller.charViewModel = self.chars[indexPath.row]
            }
        }
    }
    
}

extension MasterViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
        if (scrollOffset + scrollViewHeight >= scrollContentSizeHeight - 1000)
        {
            MarvelHttpRequests<[Char]>().requestData(endpoint: .char(self.chars.count + 1)) { (chars:Array<Char>) in
                let arraySize = self.chars.count
                let newTotal = chars.count + self.chars.count
                self.updateIndexPaths = Array(arraySize..<newTotal).map { (num) -> IndexPath in
                    return IndexPath(row: num, section: 0)
                }
                
                self.chars = self.chars + chars.map({ (char) -> CharViewModel in
                    return CharViewModel(char: char)
                })
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.view.frame.width-10)/2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "details", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "marvelCell", for: indexPath) as? MarvelCell else {
            return MarvelCell()
        }
        cell.viewModel = self.chars[indexPath.row]
        return cell
    }
    
}
