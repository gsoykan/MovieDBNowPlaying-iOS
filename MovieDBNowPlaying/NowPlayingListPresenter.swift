//
//  NowPlayingListPresenter.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import Foundation

class NowPlayingListPresenter: NowPlayingListPresenterProtocol {
    
    weak var viewControllerDelegate: NowPlayingListVCProtocol!
    
    init(delegate: NowPlayingListVCProtocol) {
        viewControllerDelegate = delegate
    }
    
    func getNowPlayingList() {
        NetworkService.shared.get(route: .getNowPlayingMovie, { [weak self] (result: Result<NowPlayingList>) in
            switch result {
            case .success(let data):
                self?.viewControllerDelegate.insertList(data: data,error: nil)
            case .failure(let error):
                self?.viewControllerDelegate.insertList(data: nil, error: error)
            }
        })
    }
}
