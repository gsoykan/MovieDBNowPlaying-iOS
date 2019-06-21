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
    var collectionSpacing: CGFloat = 8
    var list: NowPlayingList? {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
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
                self?.list = data
            case .failure(let error):
                debugPrint(error)
            }
        })
    }

}

extension NowPlayingListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let list = self.list else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingListCell.reuseID, for: indexPath) as? NowPlayingListCell else { return UICollectionViewCell() }
        cell.configure(by: list.results[indexPath.item])
        return cell
        
    }
    
}

extension NowPlayingListViewController: UICollectionViewDelegate {
    
}

extension NowPlayingListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.view.bounds.width / 2 - collectionSpacing, height: self.view.bounds.height / 2.5)
    }
    
}

