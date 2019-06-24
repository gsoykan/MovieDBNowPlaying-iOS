//
//  ViewController.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import UIKit

class NowPlayingListViewController: BaseViewController {

    @IBOutlet weak private var collectionView: UICollectionView!
    var presenterDelegate: NowPlayingListPresenterProtocol!
    private var collectionSpacing: CGFloat = 8
    private var list: NowPlayingList? {
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
    
    private func setup() {
        collectionView.registerCell(with: NowPlayingListCell.reuseID)
        VCTitle = "Now Playing"
        title = VCTitle
    }
    
    private func fetchData() {
        presenterDelegate.getNowPlayingList()
    }

}

extension NowPlayingListViewController: NowPlayingListVCProtocol {
    
    func insertList(data: NowPlayingList?, error: Error?) {
        if let data = data {
            self.list = data
        } else if let error = error {
            debugPrint(error)
        }
    }
    
}

extension NowPlayingListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let list = self.list else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingListCell.reuseID, for: indexPath) as? NowPlayingListCell else { return UICollectionViewCell() }
        cell.configure(with: list.results[indexPath.item])
        return cell
    }
    
}

extension NowPlayingListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let list = self.list else { return }
        let selectedMovie = list.results[indexPath.item]
        guard let movieDetailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return }
        movieDetailVC.movieID = String(selectedMovie.id)
        movieDetailVC.presenterDelegate = MovieDetailPresenter(delegate: movieDetailVC)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
}

extension NowPlayingListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 2 - collectionSpacing, height: view.bounds.height / 2.5)
    }
    
}

