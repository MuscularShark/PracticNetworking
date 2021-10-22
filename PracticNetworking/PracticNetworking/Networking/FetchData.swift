//
//  FetchData.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 21.10.2021.
//

import Foundation

class FetchData {
    static let shared = FetchData()

    func getData(url: URL, onCompletion: @escaping ([DataJSON]) -> ()) {
        let session = URLSession.shared

        session.dataTask(with: url) { data, _, error in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([DataJSON].self, from: data)
                onCompletion(jsonData)
            } catch {
                print(error)
            }
        }.resume()
    }
}
