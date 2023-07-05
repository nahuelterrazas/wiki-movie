//
//  WMTabBarController.swift
//  wikiMovie
//
//  Created by Nahuel Terrazas on 23/06/2023.
//

import UIKit

class WMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [createSearchNC(), createFavoritesNC(), createWatchlistNC()]
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Popular Movies"
        searchVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 0)
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    func createWatchlistNC() -> UINavigationController {
        let watchlistVC = WatchlistVC()
        watchlistVC.tabBarItem = UITabBarItem(title: "Watchlist", image: UIImage(systemName: "list.and.film"), tag: 0)
        watchlistVC.title = "Watchlist"

        return UINavigationController(rootViewController: watchlistVC)
    }

}
