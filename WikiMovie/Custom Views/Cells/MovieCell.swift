//
//  MovieCell.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 02/07/2023.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reuseID = "MovieCell"
    let movieTitle = WMTitleLabel(textAlignment: .center, fontSize: 16)
    let movieImagView = WMPosterImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(movie: Movie) {
        guard let posterPath = movie.posterPath else {
            movieImagView.image = UIImage(named: "titlePlaceholder")
            configureMovieTitle(title: movie.title)
            return
        }
        movieImagView.downloadImage(urlString: Constants().posterURL + posterPath)
    }
    
    
    private func configureMovieTitle(title: String) {
        addSubview(movieTitle)
        movieTitle.text = title
        movieTitle.numberOfLines = 0
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: topAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    private func configure() {
        addSubview(movieImagView)
        let padding: CGFloat = 3
        
        NSLayoutConstraint.activate([
            movieImagView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            movieImagView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            movieImagView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            movieImagView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        ])
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieImagView.image = UIImage(named: "placeholder")
        self.movieTitle.text = ""
    }
}
