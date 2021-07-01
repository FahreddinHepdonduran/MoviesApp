//
//  NetworkManager.swift
//  TopRatedMovies
//
//  Created by fahreddin on 1.07.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation

final class NetworkManager {
  static let shared = NetworkManager()
  private init() { }
  
  private let api = "https://api.themoviedb.org/3/movie/top_rated?api_key=47a6e2c35f01303879dd1b234a08ee06"
  
  func getMovies(completion: @escaping((Result<Movies, Error>) -> Void)) {
    guard let url = URL(string: api) else { return }
    
    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
      guard let data = data else {
        completion(.failure(error!))
        return
      }
      
      do {
        let result = try JSONDecoder().decode(Movies.self, from: data)
        completion(.success(result))
      } catch {
        completion(.failure(error))
      }
    }
    
    task.resume()
  }
}
