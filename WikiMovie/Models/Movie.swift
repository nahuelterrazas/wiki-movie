//
//  Movie.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 02/07/2023.
//

import Foundation

struct Movie: Codable, Hashable {
    let uuid = UUID()
    let id: Int
    let title: String
    let posterPath: String?
    
    private enum CodingKeys: String, CodingKey { case id, title, posterPath }
}

struct MovieList: Codable {
    let results: [Movie]
}
