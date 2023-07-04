//
//  Constants.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 03/07/2023.
//

import Foundation

struct Constants {
    let MovieListURL = "https://api.themoviedb.org/3/movie/popular?api_key=4b452ba5ff549d0ac307751b505870d5&page="
    let posterURL = "https://image.tmdb.org/t/p/w600_and_h900_bestv2"
    let backdropURL = "https://image.tmdb.org/t/p/w600_and_h900_bestv2"
    func movieUrl(id: Int) -> String {
        "https://api.themoviedb.org/3/movie/\(id)?api_key=4b452ba5ff549d0ac307751b505870d5&page=1"
    }
    
}
