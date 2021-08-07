//
//  NetworkRequest.swift
//  StudioGhilbiApps
//
//  Created by Septian-GLI on 07/08/21.
//

import Foundation

public enum RequestType: String {
    case GET, POST
}

protocol NetworkRequest {
    var method: RequestType { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

extension NetworkRequest {
    func request(with baseURL: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        components.queryItems = parameters.map({ (key, value) in
            URLQueryItem(name: key, value: value)
        })
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
