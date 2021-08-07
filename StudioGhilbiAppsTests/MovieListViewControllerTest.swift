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
    
    func test_viewDidLoad_renderMovieDataCount() {
        let sut = makeSUT(list: movieListData())
        XCTAssertEqual(sut.movieListCollectionView.numberOfItems(inSection: 0), 3)
    }
    
    func test_viewDidLoad_renderMovieDataCountWithReactive() {
        let sut = makeSUT(list: movieListData())
        XCTAssertEqual(sut.movieListCollectionView.numberOfItems(inSection: 0), 3)
    }
    
    // Mark: Helper
    
    func makeSUT(searchKey: String = "",
                 list: [Movie] = []) -> MovieListViewController {
        let sut = MovieListViewController(searchKey: searchKey, list: list)
        _ = sut.view
        return sut
    }
    
    private func movieListData() -> [Movie] {
        var movieList = [Movie]()
        let movieData1 = Movie(title: "Castle in the Sky",
                              description: "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.",
                              releaseYear: "1986",
                              director: "Hayao Miyazaki")
        let movieData2 = Movie(title: "Grave of the Fireflies",
                              description: "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.",
                              releaseYear: "1988",
                              director: "Isao Takahata")
        let movieData3 = Movie(title: "y Neighbor Totoro",
                              description: " sisters move to the country with their father in order to be closer to their hospitalized mother, and discover the surrounding trees are inhabited by Totoros, magical spirits of the forest. When the youngest runs away from home, the older sister seeks help from the spirits to find her.",
                              releaseYear: "1988",
                              director: "Hayao Miyazaki")
        
        movieList.append(movieData1)
        movieList.append(movieData2)
        movieList.append(movieData3)
        
        return movieList
    }
}
