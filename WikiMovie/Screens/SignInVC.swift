//
//  LoginVC.swift
//  wikiMovie
//
//  Created by Nahuel Terrazas on 23/06/2023.
//

import UIKit

class SignInVC: UIViewController, UITextFieldDelegate {

    let loginView = UIView()
    let usernameTextField = WMTextField()
    let passwordTextField = WMTextField()
    let callToActionButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUsernameTF()
        configurePasswordTF()
        configureCallToActionButton()
        createDismissKeyboardGesture()
        view.backgroundColor = .secondarySystemBackground
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    func configureUsernameTF() {
        view.addSubview(usernameTextField)
        usernameTextField.placeholder = "Email or username"
        usernameTextField.returnKeyType = .continue
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configurePasswordTF() {
        view.addSubview(passwordTextField)
        passwordTextField.placeholder = "Password"
        passwordTextField.returnKeyType = .done
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCallToActionButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .systemRed
        configuration.title = "Sign In"
        
        view.addSubview(callToActionButton)
        callToActionButton.configuration = configuration
        callToActionButton.translatesAutoresizingMaskIntoConstraints = false
        callToActionButton.addTarget(self, action: #selector(authentication), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    
    @objc func authentication() { view.window?.rootViewController = WMTabBarController() } // soon

}
