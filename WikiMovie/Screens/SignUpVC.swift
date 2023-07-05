//
//  SignUpVC.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 29/06/2023.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    let usernameTextField = WMTextField()
    let emailTextField = WMTextField()
    let passwordTextField = WMPasswordTextField()
    let callToActionButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground

        configureUsernameTF()
        configureEmailTF()
        configurePasswordTF()
        configureCallToActionButton()
        createDismissKeyboardGesture()
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    func configureUsernameTF() {
        view.addSubview(usernameTextField)
        usernameTextField.placeholder = "Username"
        usernameTextField.returnKeyType = .continue
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureEmailTF() {
        view.addSubview(emailTextField)
        emailTextField.placeholder = "Email"
        emailTextField.returnKeyType = .continue
        emailTextField.textContentType = .emailAddress

        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configurePasswordTF() {
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCallToActionButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Create Account"

        view.addSubview(callToActionButton)
        callToActionButton.configuration = configuration
        callToActionButton.translatesAutoresizingMaskIntoConstraints = false
        callToActionButton.addTarget(self, action: #selector(registerRequest), for: .touchUpInside)

        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    
    func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func registerRequest() {
        showLoadingView()
        let userToRegister = RegisterUser(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
        
        if !usernameTextField.hasText || !passwordTextField.hasText {
            presentAlert(title: "Error", message: "Please complete all required fields", buttonTitle: "Return", buttonStyle: .cancel)
            return
        }
        
        AuthService.shared.registerUser(with: userToRegister) { wasRegistered, error in
            DispatchQueue.main.async {
                if wasRegistered {
                    
                    let alert = UIAlertController(title: "Completed", message: "Your new account has been registered", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: { _ in
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setNewRootViewController()
                    }))
                    self.present(alert, animated: true)
                } else {
                    self.presentAlert(title: "Error", message: error?.localizedDescription ?? "", buttonTitle: "Return", buttonStyle: .destructive)
                }
            }
        }
    }
}
