//
//  WMShowPasswordButton().swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 29/06/2023.
//

import UIKit

class WMShowHideButton: UIButton {
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(textField: WMPasswordTextField) {
        super.init(frame: .zero)

        configure()
    }
    
    func configure() {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "eye.slash")
        configuration.baseBackgroundColor = .quaternarySystemFill
        configuration.baseForegroundColor = .tertiaryLabel
        self.configuration = configuration
    }

    

    
}
