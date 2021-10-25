//
//  ExtensionIdentiferVC.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 20.10.2021.
//

import UIKit

extension UIStoryboard {
    static func instantiateViewController<T: UIViewController>() -> T {
        let main = UIStoryboard(name: "Main", bundle: nil)
          
        guard let viewController = main.instantiateViewController(withIdentifier: T.identifier) as? T
        else {
            fatalError("Couldn't instantiate view controller")
        }
        
        return viewController
    }
}

extension UIViewController {
    class var identifier: String {
        return String(describing: self)
    }
}
