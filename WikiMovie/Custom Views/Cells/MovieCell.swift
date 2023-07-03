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
//        movieImagView.downloadImage = movie.posterPath
    }
    
    private func configure() {
        addSubview(movieImagView)
        let padding: CGFloat = 3
        
        NSLayoutConstraint.activate([
            movieImagView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            movieImagView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            movieImagView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            movieImagView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        ])
    }
}
