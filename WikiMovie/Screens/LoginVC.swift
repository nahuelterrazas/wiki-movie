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
    let callToCreateAccountButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppIconImageView()
        configureUsernameTF()
        configurePasswordTF()
        configureSignInButton()
        configureCallToSignUpScreen()
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
        signInButton.addTarget(self, action: #selector(authentication), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCallToSignUpScreen() {

        var configuration = UIButton.Configuration.filled()
        configuration.title = "Sign Up Now"
        configuration.baseBackgroundColor = .placeholderText

        view.addSubview(callToCreateAccountButton)
        callToCreateAccountButton.configuration = configuration
        callToCreateAccountButton.addTarget(self, action: #selector(pushSignUpVC), for: .touchUpInside)
        callToCreateAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            callToCreateAccountButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            callToCreateAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            callToCreateAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            callToCreateAccountButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
    
    func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            usernameTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    
    @objc func authentication() {
        
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            presentAlert(title: "Error", message: "Please enter your credentials", buttonTitle: "Return", buttonStyle: .destructive)
            return
        }
        
        let loginUser = LoginUser(
            email: usernameTextField.text!,
            password: passwordTextField.text!)
        
        AuthService.shared.signIn(with: loginUser, completion: { result, error in
            if result {
                self.view.window?.rootViewController = WMTabBarController()
            } else {
                print("User not registered")
                self.presentAlert(title: "Unknown User", message: error?.localizedDescription ?? "", buttonTitle: "Return", buttonStyle: .destructive)
            }
            
        })
    }
    
    @objc func pushSignUpVC() {
        let signUpVC = SignUpVC()
        signUpVC.title = "Sign Up"
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}
