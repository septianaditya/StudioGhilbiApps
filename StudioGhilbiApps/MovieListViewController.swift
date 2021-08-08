//
//  MovieListViewController.swift
//  StudioGhilbiApps
//
//  Created by Septian-GLI on 04/08/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieListTableView: UITableView!
    
    private let movieListViewModel = MovieListViewModel()
    private let cellIdentifier = "MovileCollectionViewCell"
    private let tableCellIdentifier = "tableCellIdentifier"
    
    private let disposeBag = DisposeBag()
    
    private var searchKey = ""
    private var movieList: [Movie] = []
    
    convenience init(searchKey: String, list: [Movie]) {
        self.init()
        self.searchKey = searchKey
        self.movieList = list
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movie List"
        
        registerTableView()
        searchBar.text = searchKey
        
        configureReactiveBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        movieList = movieListData()
        
//        movieListCollectionView.reloadData()
//        movieListViewModel.fetchMovieWithDummyData()
        movieListViewModel.fetchMovie()
    }
    
    func registerTableView() {
        
        movieListTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: tableCellIdentifier)
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
        let movieData3 = Movie(title: "My Neighbor Totoro",
                              description: "Two sisters move to the country with their father in order to be closer to their hospitalized mother, and discover the surrounding trees are inhabited by Totoros, magical spirits of the forest. When the youngest runs away from home, the older sister seeks help from the spirits to find her.",
                              releaseYear: "1988",
                              director: "Hayao Miyazaki")
        
        movieList.append(movieData1)
        movieList.append(movieData2)
        movieList.append(movieData3)
        
        return movieList
    }
}

extension MovieListViewController {
    private func configureReactiveBinding() {
        movieListViewModel.movieListSubject.asObserver()
            .bind(to: movieListTableView.rx.items(cellIdentifier: tableCellIdentifier)) { index, movie, cell in
                cell.textLabel?.text = movie.title ?? ""
                cell.detailTextLabel?.text = "(\(movie.releaseYear ?? ""))"
                cell.textLabel?.adjustsFontSizeToFitWidth = true
            }.disposed(by: disposeBag)
        
//        searchBar.rx.text.asObservable()
//            .map { ($0 ?? "").lowercased()() }
//            .map { UniversityRequest(name: $0) }
//            .flatMapLatest { [unowned self] request -> Observable<[UniversityModel]> in
//                return self.apiClient.send(apiRequest: request)
//            }
//            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { index, model, cell in
//                cell.textLabel?.text = model.name
//                cell.detailTextLabel?.text = model.description
//                cell.textLabel?.adjustsFontSizeToFitWidth = true
//            }
//            .disposed(by: disposeBag)
        
//        searchBar.rx.text.asObservable()
//            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .map { $0 ?? "" }
//            .subscribe { query in
//                self.movieListViewModel.filterMovieByYear(year: query )
//            }.disposed(by: disposeBag)
        
//        searchBar.rx.text.asObservable()
//            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .map { query in
//                self.movieListViewModel.movieListAll
//            }
            
        
        movieListTableView.rx.modelSelected(Movie.self)
            .subscribe { [weak self] movie in
                guard let self = self, let movieData = movie.element else { return }
                
                let vc = MoviewDetailViewController(movie: movieData)
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: disposeBag)

    }

}
