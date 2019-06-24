//
//  NowPlayingListCell.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import UIKit

final class NowPlayingListCell: UICollectionViewCell {
    
    @IBOutlet weak private var posterImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var shortDetailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
    }
    
    func configure(with movie: MinorMovie) {
        nameLabel.text = movie.title
        shortDetailLabel.text = movie.overview
        posterImageView.setImage(with: movie.posterPath)
    }

}
