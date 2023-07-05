//
//  ForgotPasswordVC.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 02/07/2023.
//

import UIKit

class ForgotPasswordVC: UIViewController, UITextFieldDelegate {
    
    let emailTextField = WMTextField()
    let resetButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureEmailTF()
        configureResetButton()
        createDismissKeyboardGesture()
        view.backgroundColor = .secondarySystemBackground
        
        emailTextField.delegate = self
    }
    
    
    func configureEmailTF() {
        view.addSubview(emailTextField)
        emailTextField.placeholder = "Email"
        emailTextField.textContentType = .emailAddress
        emailTextField.returnKeyType = .done
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureResetButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Reset Password"
        
        view.addSubview(resetButton)
        resetButton.configuration = configuration
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.addTarget(self, action: #selector(resetPasswordRequest), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            resetButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    
    func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func resetPasswordRequest(){
        showLoadingView()
        AuthService.shared.resetPassword(email: emailTextField.text ?? "") { error in
            if let error = error {
                self.presentAlert(title: "Error", message: error.localizedDescription, buttonTitle: "Return", buttonStyle: .cancel)
            } else {
                self.presentAlert(title: "Check your inbox", message: "An email to reset your password has been sent", buttonTitle: "Return", buttonStyle: .default)
            }
            
        }
    }
}
