//
//  MovieDetailPresenter.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import Foundation

class MovieDetailPresenter: MovieDetailPresenterProtocol {
 
    weak var viewControllerDelegate: MovieDetailVCProtocol!
    
    init(delegate: MovieDetailVCProtocol) {
        self.viewControllerDelegate = delegate
    }
    
    func getMovieDetail(){
        NetworkService.shared.get(route: .getMovie(ID: viewControllerDelegate.getMovieID()), { [weak self] (result: Result<DetailedMovie>) in
            switch result {
            case .success(let data):
                self?.viewControllerDelegate.insert(movie: data, error: nil)
            case .failure(let error):
                 debugPrint("e")
                self?.viewControllerDelegate.insert(movie: nil, error: error)
            }
        })
    }
    
}
