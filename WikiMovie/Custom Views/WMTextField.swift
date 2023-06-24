//
//  WMTextField.swift
//  wikiMovie
//
//  Created by Nahuel Terrazas on 23/06/2023.
//

import UIKit

class WMTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        borderStyle = .roundedRect
        backgroundColor = .systemFill
        autocorrectionType = .no
        autocapitalizationType = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
