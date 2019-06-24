//
//  MovieDetailContracts.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import UIKit

protocol MovieDetailPresenterProtocol {
    
    func getMovieDetail()
    
}

protocol MovieDetailVCProtocol: class {
    
    func getMovieID()->String
    func insert(movie: MovieDetail?, error: Error?)
    func insert(collection: MovieCollection?, error: Error?)
    
}
