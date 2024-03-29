//
//  Misc.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with posterPath: String?){
        guard let posterPath = posterPath else { print("no poster path"); return }
        guard let imageURL = URL.init(string: Constants.BASE_API_IMAGE_URL + posterPath) else { print("incorrect image url"); return }
        self.kf.setImage(with: imageURL, placeholder: nil, options: [KingfisherOptionsInfoItem.cacheOriginalImage, .transition(.fade(1))], progressBlock: nil, completionHandler: { result in })
    }
    
}

extension UICollectionView {
   
    func registerCell(with reuseID: String){
        self.register(UINib(nibName: reuseID, bundle: nil), forCellWithReuseIdentifier: reuseID)
    }
    
}

extension UICollectionViewCell {
    
    static var reuseID: String {
        return String(describing: self)
    }
    
}
