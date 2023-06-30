//
//  WMPasswordTextView.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 29/06/2023.
//

import UIKit

class WMPasswordTextField: UITextField {
    
    var showHideButton = WMShowHideButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        borderStyle             = .roundedRect
        backgroundColor         = .systemFill
        autocapitalizationType  = .none
        placeholder             = "Password"
        textContentType         = .password
        returnKeyType           = .done
        rightViewMode           = .whileEditing
        isSecureTextEntry       = true
        
        rightView = showHideButton
        showHideButton.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
    }
    
    @objc func showHidePassword() {
        if isSecureTextEntry {
            showHideButton.setImage(UIImage(systemName: "eye"), for: .normal)
            isSecureTextEntry.toggle()
        } else {
            showHideButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            isSecureTextEntry.toggle()
        }
    }
    

    
    
}
