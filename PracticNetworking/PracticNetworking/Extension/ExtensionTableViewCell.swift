//
//  ExtensionTableViewCell.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 21.10.2021.
//

import UIKit

extension UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}
