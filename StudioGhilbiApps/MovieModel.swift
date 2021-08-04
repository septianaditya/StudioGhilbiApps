//
//  MovieModel.swift
//  StudioGhilbiApps
//
//  Created by Septian-GLI on 04/08/21.
//

import Foundation

struct MovieModel: Codable {
    var title: String?
    var description: String?
    var releaseYear: String?
    var director: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case releaseYear
        case director
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        releaseYear = try container.decodeIfPresent(String.self, forKey: .releaseYear)
        director = try container.decodeIfPresent(String.self, forKey: .director)
    }
    
    init(title: String, description: String, releaseYear: String, director: String) {
        self.title = title
        self.description = description
        self.releaseYear = releaseYear
        self.director = director
    }
}
