//
//  CollectionCell.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import UIKit

class MovieInCollectionCell: UICollectionViewCell {
        
    @IBOutlet weak private var posterImageView: UIImageView!
    
    func configure(with imagePath: String) {
        posterImageView.setImage(with: imagePath)
    }
    
}
