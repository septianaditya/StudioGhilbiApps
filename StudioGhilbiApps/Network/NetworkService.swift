//
//  NetworkService.swift
//  StudioGhilbiApps
//
//  Created by Septian-GLI on 05/08/21.
//

import Foundation
import RxSwift

class NetworkService {
//    private let networkRequest: NetworkRequest.
    
    func execute<T: Codable>(url: URL) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                    return
                }
                
                observer.onNext(decoded)
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func execute2<T: Codable>(networkRequest: NetworkRequest, url: URL) -> Observable<T> {
        let request = networkRequest.request(with: url)
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(T.self, from: data)
            }
    }
}
