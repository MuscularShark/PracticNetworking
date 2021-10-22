//
//  DataJSON.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 21.10.2021.
//

import UIKit

struct DataJSON: Decodable {
    var body: String
    var id: Int
    var title: String
    var userId: Int
}
