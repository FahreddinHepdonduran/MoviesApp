//
//  MoviesCollectionViewCell.swift
//  TopRatedMovies
//
//  Created by fahreddin on 1.07.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var moviePosterImage: UIImageView!
  @IBOutlet weak var movieTitleLabel: UILabel!
  
  override class func description() -> String {
    return "MovieCell"
  }
  
}
