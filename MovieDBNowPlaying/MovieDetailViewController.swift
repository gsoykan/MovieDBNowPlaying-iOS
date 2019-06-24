//
//  MovieDetailViewController.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    var presenterDelegate: MovieDetailPresenterProtocol!
    var movieID: String!
    private var movie: MovieDetail? {
        didSet {
            guard let movie = self.movie else { return }
            DispatchQueue.main.async {
                self.configure(with: movie)
            }
        }
    }
    private var movieCollection: MovieCollection? {
        didSet {
            guard self.movieCollection != nil else { return }
            DispatchQueue.main.async {
                self.collectionCollectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak private var posterImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var taglineLabel: UILabel!
    @IBOutlet weak private var genresLabel: UILabel!
    @IBOutlet weak private var overviewLabel: UILabel!
    @IBOutlet weak private var collectionCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenterDelegate.getMovieDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setup() {
        VCTitle = "Movie"
        title = VCTitle
    }
    
    private func configure(with movie: MovieDetail) {
        posterImageView.setImage(with: movie.posterPath)
        titleLabel.text = movie.title
        taglineLabel.text = movie.tagline
        let genreNames = movie.genres.map({ genre in genre.name })
        let genreString = genreNames.joined(separator: ", ")
        genresLabel.text = "Genres: " + genreString
        overviewLabel.text = movie.overview
        if let collectionID =  movie.belongsToCollection {
            collectionCollectionView.isHidden = false
            print("Belongs to collection with ID: \(collectionID)")
        } else {
            collectionCollectionView.isHidden = true
        }
    }
    
}

extension MovieDetailViewController: MovieDetailVCProtocol {
    
    func getMovieID()->String {
        return movieID
    }
    
    func insert(movie: MovieDetail?, error: Error?) {
        if let movie = movie {
            self.movie = movie
        } else if let error = error {
            print(error)
        }
    }
    
    func insert(collection: MovieCollection?, error: Error?) {
        if let collection = collection {
            self.movieCollection = collection
        } else if let error = error {
            print(error)
        }
    }
    
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCollection?.parts.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCollection = self.movieCollection else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieInCollectionCell.reuseID, for: indexPath) as? MovieInCollectionCell else { return UICollectionViewCell() }
        cell.configure(with: movieCollection.parts[indexPath.item].posterPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let collection = self.movieCollection else { return }
        let selectedMovie = collection.parts[indexPath.item]
        guard  String(selectedMovie.id) != movieID  else { return }
        guard let movieDetailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return }
        movieDetailVC.movieID = String(selectedMovie.id)
        movieDetailVC.presenterDelegate = MovieDetailPresenter(delegate: movieDetailVC)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
}

