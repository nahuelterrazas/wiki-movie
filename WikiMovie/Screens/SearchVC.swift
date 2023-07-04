//
//  SearchVC.swift
//  wikiMovie
//
//  Created by Nahuel Terrazas on 23/06/2023.
//

import UIKit

class SearchVC: UIViewController {
    
    enum Section{case main}
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    var page = 1
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureSearchController()
        getMovies()
        configureDataSource()
    }

    
    func configureViewController(){
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Seach a movie"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.set(movie: itemIdentifier)
            return cell
        })
    }
    
    
    func updateData(on movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    
    func getMovies() {
        showLoadingView()
        NetworkManager.shared.getMovies(page: self.page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case.success(let moviesList):
                self.movies.append(contentsOf: moviesList.results)
                self.updateData(on: self.movies)
            case.failure(let error):
                self.presentAlert(title: "Error", message: error.localizedDescription, buttonTitle: "Cancel", buttonStyle: .destructive)
            }
        }
    }
    
    
    func searchMovies(title: String){
        NetworkManager.shared.getMovies (title: title) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let moviesList):
                self.updateData(on: moviesList.results)
            case.failure(let error):
                self.presentAlert(title: "Error", message: error.localizedDescription, buttonTitle: "Cancel", buttonStyle: .destructive)
            }
        }
    }
}


extension SearchVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offSetY > contentHeight - height {
            guard page<9, !isSearching else {return}
            page+=1
            getMovies()
        }
    }
}


extension SearchVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: movies)
            return
        }
        searchMovies(title: filter.replacingOccurrences(of: " ", with: "+"))
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: movies)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) { isSearching = true }
}
