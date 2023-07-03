//
//  LoginVC.swift
//  wikiMovie
//
//  Created by Nahuel Terrazas on 23/06/2023.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    let appIconImageView = UIImageView()
    let usernameTextField = WMTextField()
    let passwordTextField = WMPasswordTextField()
    let signInButton = UIButton()
    let createAccountButton = UIButton()
    let forgotPasswordButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppIconImageView()
        configureUsernameTF()
        configurePasswordTF()
        configureSignInButton()
        configureCreateAccountButton()
        configureForgotPasswordButton()
        createDismissKeyboardGesture()
        view.backgroundColor = .secondarySystemBackground
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    func configureAppIconImageView() {
        view.addSubview(appIconImageView)
        appIconImageView.translatesAutoresizingMaskIntoConstraints = false
        appIconImageView.image = UIImage(named: "popcorn")
        appIconImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            appIconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            appIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appIconImageView.widthAnchor.constraint(equalToConstant: 100),
            appIconImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    func configureUsernameTF() {
        view.addSubview(usernameTextField)
        usernameTextField.placeholder = "Email"
        usernameTextField.textContentType = .emailAddress
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
        
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureSignInButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .systemRed
        configuration.title = "Sign In"
        
        view.addSubview(signInButton)
        signInButton.configuration = configuration
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.addTarget(self, action: #selector(authenticationRequest), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureForgotPasswordButton(){
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Forgot password?"
        configuration.buttonSize = .small
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.configuration = configuration
        forgotPasswordButton.addTarget(self, action: #selector(pushResetPasswordVC), for: .touchUpInside)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 10),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    
    func configureCreateAccountButton() {

        var configuration = UIButton.Configuration.plain()
        configuration.title = "New user? Create Account."

        view.addSubview(createAccountButton)
        createAccountButton.configuration = configuration
        createAccountButton.addTarget(self, action: #selector(pushSignUpVC), for: .touchUpInside)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 15),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50)
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
    
    
    @objc func authenticationRequest() {
        showLoadingView()
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            presentAlert(title: "Error", message: "Please enter your credentials", buttonTitle: "Return", buttonStyle: .destructive)
            return
        }
        
        let loginUser = LoginUser(
            email: usernameTextField.text!,
            password: passwordTextField.text!)
        
        AuthService.shared.signIn(with: loginUser, completion: { result, error in
            if result {
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setNewRootViewController()
            } else {
                print("User not registered")
                self.presentAlert(title: "Unknown User", message: error?.localizedDescription ?? "", buttonTitle: "Return", buttonStyle: .destructive)
            }
        })
    }
    
    
    @objc func pushResetPasswordVC() {
        let resetVC = ForgotPasswordVC()
        resetVC.title = "Password Assistance"
        self.navigationController?.pushViewController(resetVC, animated: true)
    }
    
    
    @objc func pushSignUpVC() {
        let signUpVC = SignUpVC()
        signUpVC.title = "Sign Up"
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}
