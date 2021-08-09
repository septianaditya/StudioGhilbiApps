//
//  MovieListViewControllerTest.swift
//  StudioGhilbiAppsTests
//
//  Created by Septian-GLI on 04/08/21.
//

import Foundation
import XCTest
import RxSwift
import RxCocoa
@testable import StudioGhilbiApps

class MovieListViewControllerTest: XCTestCase {
    func test_viewDidLoad_renderNoSearchKeyNoData() {
        let sut = MovieListViewController(searchKey: "", list: [])
        
        _ = sut.view
        
        XCTAssertEqual(sut.searchBar.text, "")
    }
    
    func test_viewDidLoad_renderWithSearchKeyText() {
        let sut = MovieListViewController(searchKey: "1988", list: [])
        
        _ = sut.view
        
        XCTAssertEqual(sut.searchBar.text, "1988")
    }
    
    // Mark: Helper
    
    func makeSUT(searchKey: String = "",
                 list: [Movie] = []) -> MovieListViewController {
        let sut = MovieListViewController(searchKey: searchKey, list: list)
        _ = sut.view
        return sut
    }
}
