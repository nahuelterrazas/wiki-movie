//
//  Movie.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 02/07/2023.
//

import Foundation

struct Movie: Codable, Hashable {
    let id: Int
    let title: String
    let posterPath: String?
}

struct MovieList: Codable, Hashable {
    let results: [Movie]
}
