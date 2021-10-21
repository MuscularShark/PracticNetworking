//
//  Data.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 21.10.2021.
//

import UIKit

struct DataJson: Decodable {
    var body: String
    var id: Int
    var title: String
    var userId: Int
}
