//
//  MovieDetailsViewController.swift
//  TopRatedMovies
//
//  Created by fahreddin on 2.07.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
  @IBOutlet private weak var overviewTextView: UITextView!
  @IBOutlet private weak var releaseDateLabel: UILabel!
  @IBOutlet private weak var originalTitleLabel: UILabel!
  @IBOutlet private weak var originalLanguageLabel: UILabel!
  @IBOutlet private weak var populationLabel: UILabel!
  @IBOutlet private weak var voteCountLabel: UILabel!
  @IBOutlet private weak var voteAverageLabel: UILabel!
  
  var movie: Movie?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
}

private extension MovieDetailsViewController {
  func configure() {
    guard let movie = self.movie else { return }
    
    self.overviewTextView.text = movie.overview
    self.releaseDateLabel.text = movie.releaseDate
    self.originalTitleLabel.text = movie.originalTitle ?? ""
    self.originalLanguageLabel.text = movie.originalLanguage
    self.populationLabel.text = "\(movie.popularity)"
    self.voteCountLabel.text = "\(movie.voteCount)"
    self.voteAverageLabel.text = "\(movie.voteAverage)"
  }
}
