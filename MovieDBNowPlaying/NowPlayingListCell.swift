//
//  NowPlayingListCell.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import UIKit

class NowPlayingListCell: UICollectionViewCell {

    static let reuseID: String = "NowPlayingListCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shortDetailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = true
    }
    
    func configure(by movie: MinorMovie){
        self.nameLabel.text = movie.title
        self.shortDetailLabel.text = movie.overview
        self.posterImageView.setImage(with: movie.posterPath)
    }

}
