//
//  ViewController.swift
//  TopRatedMovies
//
//  Created by fahreddin on 1.07.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  private var movies: Movies!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NetworkManager.shared.getMovies { [weak self] (result) in
      
      switch result {
      case .success(let movies):
        self?.movies = movies
      case .failure(let error):
        print(error.localizedDescription)
      }
      
    }
  }


}

