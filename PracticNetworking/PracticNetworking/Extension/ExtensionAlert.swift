//
//  ExtensionAlert.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 22.10.2021.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, action: UIAlertAction..., type: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: type)

        for (_, element) in action.enumerated() {
            alertController.addAction(element)
        }
        present(alertController, animated: true, completion: nil)
    }
}
