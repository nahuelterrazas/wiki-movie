//
//  UIViewController+Ext.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 29/06/2023.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String, buttonTitle: String, buttonStyle: UIAlertAction.Style){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle , style: buttonStyle))
            self.present(alert, animated: true)
        }
    }
}


