//
//  ViewController.swift
//  wikiMovie
//
//  Created by Nahuel Terrazas on 23/06/2023.
//

import UIKit

class HomeScreenVC: UIViewController {

    let titleLabel = UILabel()
    let appIconImageView = UIImageView()
    let callToLoginScreen = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
        configureAppIconImageView()
        configureCallToLoginScreen()
        view.backgroundColor = .systemBackground
    }

    
    func configureLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "Wiki Movie"
        titleLabel.textColor = .red
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 50)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            titleLabel.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureAppIconImageView() {
        view.addSubview(appIconImageView)
        appIconImageView.translatesAutoresizingMaskIntoConstraints = false
        appIconImageView.image = UIImage(named: "popcorn")
        appIconImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            appIconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            appIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appIconImageView.widthAnchor.constraint(equalToConstant: 200),
            appIconImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureCallToLoginScreen() {

        var configuration = UIButton.Configuration.filled()
        configuration.title = "Log In"
        configuration.baseBackgroundColor = .systemRed

        view.addSubview(callToLoginScreen)
        callToLoginScreen.configuration = configuration
        callToLoginScreen.addTarget(self, action: #selector(pushSignInVC), for: .touchUpInside)
        callToLoginScreen.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            callToLoginScreen.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            callToLoginScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            callToLoginScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            callToLoginScreen.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func pushSignInVC() {
        let signInVC = SignInVC()
        signInVC.title = "Sign In"
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
}
