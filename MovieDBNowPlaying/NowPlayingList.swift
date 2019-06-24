//
//  NowPlayingList.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import Foundation

struct NowPlayingList: Codable {
    let results: [MinorMovie]
    let page, totalResults: Int
    let dates: Dates
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results, page, dates
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct Dates: Codable {
    let maximum, minimum: String
}
