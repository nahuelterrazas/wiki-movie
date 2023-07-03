//
//  SearchVC.swift
//  wikiMovie
//
//  Created by Nahuel Terrazas on 23/06/2023.
//

import UIKit

class SearchVC: UIViewController {
    
    enum Section{
        case main
    }
    
    var movies: [Movie] = [
        Movie(id: 1, title: "", posterPath: ""),
        Movie(id: 2, title: "", posterPath: ""),
        Movie(id: 3, title: "", posterPath: ""),
        Movie(id: 4, title: "", posterPath: ""),
        Movie(id: 5, title: "", posterPath: ""),
        Movie(id: 6, title: "", posterPath: ""),
        Movie(id: 7, title: "", posterPath: ""),
        Movie(id: 8, title: "", posterPath: ""),
        Movie(id: 9, title: "", posterPath: ""),
        Movie(id: 10, title: "", posterPath: ""),
        Movie(id: 11, title: "", posterPath: ""),
        Movie(id: 12, title: "", posterPath: ""),
        Movie(id: 13, title: "", posterPath: "")
    ]

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
        updateData()
    }

    
    func configureViewController(){
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.set(movie: itemIdentifier)
            return cell
        })
    }
    
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

}
