//
//  MovieListViewModel.swift
//  StudioGhilbiApps
//
//  Created by Septian-GLI on 05/08/21.
//

import Foundation
import RxSwift

class MovieListViewModel {
    private let networkAPIService: MovieNetworkService = MovieWorker()
    
    private let disposeBag = DisposeBag()
    
    var movieListAll = PublishSubject<[Movie]>()
    var movieListSubject = PublishSubject<[Movie]>()
    var movieList = [Movie]()

    func fetchMovie() {
        
        return networkAPIService.getMovieList()
            .subscribe { [weak self] (resp) in
                guard let self = self else { return }

                guard let element = resp.element else { return }
                self.movieListSubject.onNext(element)
                self.movieListAll.onNext(element)
                self.movieList = element

            }.disposed(by: disposeBag)
        
    }
    
    func fetchMovieWithDummyData() {
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
        
        movieListSubject.onNext(movieList)
        movieListAll.onNext(movieList)
    }
    
    func filterMovieByYear(year: String) {
        Observable.from(movieList)
            .filter { movie in
                if year == "" {
                    return true
                }
                return movie.releaseYear == year
            }
            .toArray()
            .subscribe(onSuccess: { movie in
                self.movieListSubject.onNext(movie)
            })
            .disposed(by: disposeBag)
    }
}
