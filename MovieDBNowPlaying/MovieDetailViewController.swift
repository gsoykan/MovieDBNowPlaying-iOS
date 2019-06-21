//
//  MovieDetailViewController.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var presenterDelegate: MovieDetailPresenterProtocol!
    var ID: String!
    var movie: DetailedMovie? {
        didSet {
            guard let movie = self.movie else { return }
            DispatchQueue.main.async {
                self.configure(with: movie)
            }
        }
    }
    var movieCollection: MovieCollection?{
        didSet {
            guard self.movieCollection != nil else { return }
            DispatchQueue.main.async {
                self.collectionCollectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var collectionCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.presenterDelegate.getMovieDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Movie"
    }
    
    func setup(){}
    
    func configure(with movie: DetailedMovie){
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
    
    func getMovieID()->String{
        return self.ID
    }
    
    func insert(movie: DetailedMovie?, error: Error?){
        if let movie = movie {
            self.movie = movie
        } else if let error = error {
            print(error)
        }
    }
    
    func insert(collection: MovieCollection?, error: Error?){
        if let collection = collection {
            self.movieCollection = collection
        } else if let error = error {
            print(error)
        }
    }
    
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieCollection?.parts.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCollection = self.movieCollection else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseID, for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        cell.posterImageView.setImage(with: movieCollection.parts[indexPath.item].posterPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let collection = self.movieCollection else { return }
        let selectedMovie = collection.parts[indexPath.item]
        if String(selectedMovie.id) != self.ID {
            guard let movieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return }
            movieDetailVC.ID = String(selectedMovie.id)
            movieDetailVC.presenterDelegate = MovieDetailPresenter.init(delegate: movieDetailVC)
            self.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
    
}

