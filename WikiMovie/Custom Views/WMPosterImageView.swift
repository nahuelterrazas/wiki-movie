//
//  WMPosterImageView.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 02/07/2023.
//

import UIKit

class WMPosterImageView: UIImageView {
    
    let placeholder = UIImage(named: "poster")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholder
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(){}
    
    
}
