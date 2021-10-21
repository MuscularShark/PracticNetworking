//
//  JsonTableViewCell.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 21.10.2021.
//

import UIKit

class JsonTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    
    static func nib() -> UINib { return UINib(nibName: JsonTableViewCell.identifier, bundle: nil) }
    
    func setupCell(data: DataJson) {
        titleLabel.text = data.title
        taskLabel.text = data.body
    }
}
