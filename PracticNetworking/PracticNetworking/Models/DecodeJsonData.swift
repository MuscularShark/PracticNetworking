//
//  DecodeJsonData.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 21.10.2021.
//

import UIKit

class DecodeJsonData {
    
    var arr = [Date]()
    
    func getData() -> [Data] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { fatalError() }
        
        let session = URLSession.shared
        
        let arr = [Date]()
        
        session.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let dates = try decoder.decode([Date].self, from: data)
                
            } catch {
                print(error)
            }
        }.resume()
    }
}
