//
//  MovieWorker.swift
//  StudioGhilbiApps
//
//  Created by Septian-GLI on 06/08/21.
//

import Foundation
import RxSwift

protocol MovieNetworkService {
    func getMovieList() -> Observable<[Movie]>
}

class MovieRequest: NetworkRequest {
    var method: RequestType = .GET
    var path: String = ""
    var parameters: [String : String] = [:]
    
    init() {
        
    }
}

class MovieWorker: MovieNetworkService {
    
    private let networkService = NetworkService()
    private let baseUrlString = "https://ghibliapi.herokuapp.com"
    
    private let networkRequest: NetworkRequest = MovieRequest()
    
    private let disposeBag = DisposeBag()
    
    func getMovieList() -> Observable<[Movie]> {

        return networkService.execute2(networkRequest: networkRequest, url: URL(string: baseUrlString + "/films")!) //(url: URL(string: baseUrlString + "/films")!)
    }
}
