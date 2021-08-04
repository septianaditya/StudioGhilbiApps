//
//  MovieListViewControllerTest.swift
//  StudioGhilbiAppsTests
//
//  Created by Septian-GLI on 04/08/21.
//

import Foundation
import XCTest
@testable import StudioGhilbiApps

class MovieListViewControllerTest: XCTestCase {
    func test_viewDidLoad_renderNoSearchKey() {
        let sut = MovieListViewController(searchKey: "", list: [])
        
        _ = sut.view
        
        XCTAssertEqual(sut.searchTextField.text, "")
    }
    
    func test_viewDidLoad_renderWithSearchKeyText() {
        let sut = MovieListViewController(searchKey: "1988", list: [])
        
        _ = sut.view
        
        XCTAssertEqual(sut.searchTextField.text, "1988")
    }
    
    func test_viewDidLoad_renderMovieNoData() {
        let sut = MovieListViewController(searchKey: "", list: [])
        
        _ = sut.view
        
        XCTAssertEqual(sut.movieListCollectionView.numberOfItems(inSection: 0), 0)
    }
}
