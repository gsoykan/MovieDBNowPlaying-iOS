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
    var presenterDelegate: NowPlayingListPresenterProtocol!
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
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Now Playing"
    }
    
    func setup(){
        collectionView.register(UINib.init(nibName: NowPlayingListCell.reuseID, bundle: nil), forCellWithReuseIdentifier: NowPlayingListCell.reuseID)
    }
    
    func fetchData(){
        self.presenterDelegate.getNowPlayingList()
    }

}

extension NowPlayingListViewController: NowPlayingListVCProtocol {
    
    func insertList(data: NowPlayingList?, error: Error?){
        if let data = data {
            self.list = data
        } else if let error = error {
            debugPrint(error)
        }
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

