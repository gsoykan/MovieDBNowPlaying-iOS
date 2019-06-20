//
//  ViewController.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import UIKit

class NowPlayingListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        simpleCall()
    }
    
    func setup(){
        collectionView.register(UINib.init(nibName: NowPlayingListCell.reuseID, bundle: nil), forCellWithReuseIdentifier: NowPlayingListCell.reuseID)
    }
    
    func simpleCall(){
        NetworkService.shared.get(route: .getNowPlayingMovies, { [weak self] (result: Result<NowPlayingList>) in
            switch result {
            case .success(let data):
                debugPrint(data)
            case .failure(let error):
                debugPrint(error)
            }
        })
    }

}

extension NowPlayingListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

extension NowPlayingListViewController: UICollectionViewDelegate {
    
}

