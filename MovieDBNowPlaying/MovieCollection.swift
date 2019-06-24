//
//  MovieCollection.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import Foundation

struct MovieCollection: Codable {
    let id: Int
    let name, overview: String
    let posterPath: String?
    let backdropPath: String?
    let parts: [MinorMovie]
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview, parts
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
