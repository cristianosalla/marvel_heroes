//
//  Marvel_HeroesTests.swift
//  Marvel_HeroesTests
//
//  Created by Cristiano Salla Lunardi on 09/12/19.
//  Copyright © 2019 Cristiano Salla Lunardi. All rights reserved.
//

import XCTest
@testable import Marvel_Heroes

class Marvel_HeroesTests: XCTestCase {

    var marvelComicsRequest = MarvelHttpRequests<[Comic]>()
    var marvelCharRequest = MarvelHttpRequests<[Char]>()
    var detailViewController = DetailViewController()
    
    override func setUp() {
        super.setUp()
    }
    
    func testCharRequest() {
        let expectation = self.expectation(description: "char expectation")
        let offset = 0
        
        marvelCharRequest.requestData(endpoint: .char(offset)) { (chars) in
            XCTAssertEqual(chars.count, 20, "20 chars")
            
            let charViewModel = CharViewModel(char: chars[Int.random(in: 0..<20)])
            XCTAssertNotNil(charViewModel.id, "id")
            //XCTAssertNotNil(charViewModel.image, "image")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testComicRequest() {
        let expectation = self.expectation(description: "comic expectation")
        let offset: Int = 0
        let id: Int = 1010801
        
        marvelComicsRequest.requestData(endpoint: .comic(offset, id)) { (comics) in
            XCTAssertEqual(comics.count, 20, "20 chars")
            
            let comicViewModel = ComicViewModel(comic: comics[Int.random(in: 0..<20)])
            XCTAssertNotNil(comicViewModel, "comic view model is not nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDownloadImage() {
        let expectation = self.expectation(description: "download image expectation")
        marvelCharRequest.downloadImage(thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", ext: "jpg")) { (imageString) in
            
            let image = UIImage(data: Data(base64Encoded: imageString) ?? Data())
            
            XCTAssertNotNil(image, "Image not nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDetailViewController() {
        let indexPathSize = 20
        let randomIndexesMax = 100
        let indexPath = (0...indexPathSize).map{ (index) -> IndexPath in
            return IndexPath(item: Int.random(in: 0..<randomIndexesMax), section: 0)
        }
        detailViewController.updateIndexPaths = indexPath
        XCTAssertEqual(indexPath, detailViewController.updateIndexPaths, "index paths equals")
        
    }
}
