//
//  UIViewController+Alert.swift
//  Baluchon
//
//  Created by Déborah Suon on 09/12/2021.
//

import Foundation
import UIKit


extension UIViewController {
// ALERT
    func presentAlert(with message: String) {
        let alertController: UIAlertController = .init(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
}
