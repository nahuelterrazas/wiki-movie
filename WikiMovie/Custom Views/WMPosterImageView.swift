//
//  WMPosterImageView.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 02/07/2023.
//

import UIKit

class WMPosterImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeholder = UIImage(named: "placeholder")

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
    
    func downloadImage(urlString: String){
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey){
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if let _ = error { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self?.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        task.resume()
    }
    
    
}
