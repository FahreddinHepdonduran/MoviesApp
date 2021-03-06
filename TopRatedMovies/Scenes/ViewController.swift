//
//  ViewController.swift
//  TopRatedMovies
//
//  Created by fahreddin on 1.07.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

  @IBOutlet private weak var collectionView: UICollectionView!
  
  private var movies: Movies!
  private let movieImageAPI: String = "https://image.tmdb.org/t/p/original"
  private var imageCache: [String : UIImage] = [:]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionViewLayout()
    getMovies()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "ToMovieDetailsSegue",
          let movie = sender as? Movie else {return}
    
    let destinationVC = segue.destination as! MovieDetailsViewController
    destinationVC.movie = movie
  }

}

extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movie = movies.results[indexPath.row]
    performSegue(withIdentifier: "ToMovieDetailsSegue", sender: movie)
  }
}

extension ViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies == nil ? 0 : movies.results.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.description(),
                                                  for: indexPath) as! MoviesCollectionViewCell
    if let posterImage = imageCache[self.movieImageAPI + movies.results[indexPath.row].imagePath] {
      cell.moviePosterImage.image = posterImage
      cell.movieTitleLabel.text = movies.results[indexPath.row].title
      cell.movieTitleLabel.isHidden = false
    } else {
      downloadWithUrlSession(at: indexPath)
    }
    return cell
  }
}

private extension ViewController {
  func getMovies() {
    NetworkManager.shared.getMovies { [weak self] (result) in
      
      switch result {
      case .success(let movies):
        self?.movies = movies
        DispatchQueue.main.async {
          self?.collectionView.reloadData()
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
      
    }
  }
  
  func collectionViewLayout() {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 200, height: 300)
    collectionView.collectionViewLayout = layout
  }
  
  func downloadWithUrlSession(at indexPath: IndexPath) {
    let urlString = self.movieImageAPI + movies.results[indexPath.row].imagePath
    guard let url = URL(string: urlString) else {return}
    
    URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
      guard let self = self,
            let data = data,
            let image = UIImage(data: data) else {return}
      
      self.imageCache[urlString] = image
      
      DispatchQueue.main.async {
        guard let cell = self.collectionView
          .cellForItem(at: indexPath) as? MoviesCollectionViewCell else {return}
        cell.moviePosterImage.image = image
        cell.movieTitleLabel.text = self.movies.results[indexPath.row].title
        cell.movieTitleLabel.isHidden = false
      }
    }
    .resume()
  }
}
