//
//  UIViewController+Ext.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 29/06/2023.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    func presentAlert(title: String, message: String, buttonTitle: String, buttonStyle: UIAlertAction.Style){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle , style: buttonStyle))
            self.present(alert, animated: true)
            self.dismissLoadingView()
        }
    }
    
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .secondarySystemBackground
        containerView.alpha = 0
        UIView.animate(withDuration: 0.25) {containerView.alpha = 0.8}
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        containerView.removeFromSuperview()
        containerView = nil
    }
}


