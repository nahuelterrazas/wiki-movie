//
//  NetworkManager.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 03/07/2023.
//

import UIKit

class NetworkManager{
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getMovies(page: Int, completed: @escaping (Result<MovieList, WMError>)->Void){
        
        guard let url = URL(string: Constants().MovieListURL+String(page)) else { return }

        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode(MovieList.self, from: data)
                completed(.success(movies))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
}
