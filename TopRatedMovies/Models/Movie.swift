//
//  Movie.swift
//  TopRatedMovies
//
//  Created by fahreddin on 1.07.2021.
//  Copyright © 2021 fahreddin. All rights reserved.
//

import Foundation

struct Movie: Codable {
  let id: Int
  let originalLanguage: String
  let originalTitle: String?
  let overview: String
  let popularity: Double
  let imagePath: String
  let releaseDate: String
  let title: String
  let voteAverage: Double
  let voteCount: Int
}

extension Movie {
  enum CodingKeys: String, CodingKey {
    case id
    case originalLanguage = "original_language"
    case originalTitle = "original_litle"
    case overview
    case popularity
    case imagePath = "poster_path"
    case releaseDate = "release_date"
    case title
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}
