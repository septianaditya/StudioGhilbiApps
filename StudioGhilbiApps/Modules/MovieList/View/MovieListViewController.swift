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
    
    let movieListViewModel = MovieListViewModel()
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
        
        movieListViewModel.fetchMovie()
    }
    
    func registerTableView() {
        
        movieListTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: tableCellIdentifier)
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
        
        searchBar.rx.text.asObservable()
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { $0 ?? "" }
            .subscribe { query in
                self.movieListViewModel.filterMovieByYear(year: query)
            }.disposed(by: disposeBag)
        
        movieListTableView.rx.modelSelected(Movie.self)
            .subscribe { [weak self] movie in
                guard let self = self, let movieData = movie.element else { return }
                
                let vc = MoviewDetailViewController(movie: movieData)
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: disposeBag)

    }
}
