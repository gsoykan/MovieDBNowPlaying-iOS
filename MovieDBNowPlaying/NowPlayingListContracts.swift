//
//  NowPlayingListContracts.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import Foundation

protocol NowPlayingListVCProtocol: class {
    
    func insertList(data: NowPlayingList?, error: Error?)
    
}

protocol NowPlayingListPresenterProtocol {
    
    func getNowPlayingList()
    
}
